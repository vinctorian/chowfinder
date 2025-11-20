import 'package:chowfinder/core/injector.dart';
import 'package:chowfinder/data/domain/entity/place_types_enum.dart';
import 'package:chowfinder/data/domain/entity/rank_preference_enum.dart';
import 'package:chowfinder/data/domain/usecase/get_restaurants_usecase.dart';
import 'package:chowfinder/presentation/pages/bloc/restaurant_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RestaurantListPage extends StatelessWidget {
  final double radius;
  const RestaurantListPage({super.key, required this.radius});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RestaurantListBloc(
        usecase: GetRestaurantsUsecaseImpl(repository: Injector.get()),
      )..add(LoadListEvent(radius: 500)),
      child: RetaurantListPageView(radius: radius),
    );
  }
}

class RetaurantListPageView extends StatefulWidget {
  final double radius;
  const RetaurantListPageView({super.key, required this.radius});

  @override
  State<RetaurantListPageView> createState() => _RetaurantListPageViewState();
}

class _RetaurantListPageViewState extends State<RetaurantListPageView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: Semantics(
            label: "go back",
            child: IconButton(
              onPressed: () => Navigator.of(context).maybePop(),
              icon: Icon(Icons.close),
            ),
          ),
        ),
        floatingActionButton: IconButton(
          onPressed: () => context.read<RestaurantListBloc>().add(
            LoadListEvent(radius: widget.radius),
          ),
          icon: Icon(Icons.refresh),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            context.read<RestaurantListBloc>().add(
              LoadListEvent(radius: widget.radius),
            );
          },
          child: BlocConsumer<RestaurantListBloc, RestaurantListState>(
            listener: (context, state) {},
            builder: (context, state) {
              return switch (state) {
                RestaurantLoadedState() => Column(
                  spacing: 8.0,

                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      child: SizedBox(
                        height: 44,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: PlaceTypeEnum.values.map((e) {
                              final selected =
                                  state.includedTypes?.contains(e) ?? false;
                              return Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: FilterChip(
                                  label: Text(e.name),
                                  selected: selected,
                                  onSelected: (selected) => context
                                      .read<RestaurantListBloc>()
                                      .add(AddTypeEvent(type: e)),
                                  selectedColor: Theme.of(
                                    context,
                                  ).colorScheme.onSecondary,
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      child: SizedBox(
                        height: 44,
                        child: Row(
                          children: RankPreferenceEnum.values.map((rank) {
                            final selected = state.rankPreference == rank;
                            return Expanded(
                              child: CheckboxListTile(
                                value: selected,
                                title: Text(
                                  "rank by:${rank.name}",
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                onChanged: (bool) => context
                                    .read<RestaurantListBloc>()
                                    .add(AddRankEvent(rank: rank)),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: ListView.separated(
                          itemBuilder: (BuildContext context, int index) {
                            if (index == state.restaurants.length)
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            final item = state.restaurants[index];
                            return ListTile(
                              title: Text(
                                item.displayName,
                                semanticsLabel:
                                    "restaurant $index ${item.displayName}",
                              ),
                              subtitle: Text(
                                item.formattedAddress,
                                semanticsLabel:
                                    "address $index ${item.formattedAddress}",
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) =>
                              const Divider(height: 1),
                          itemCount: state.restaurants.length + 1,
                        ),
                      ),
                    ),
                  ],
                ),
                RestaurantErrorState() => Center(child: Text("error")),
                _ => const Center(child: CircularProgressIndicator()),
              };
            },
          ),
        ),
      ),
    );
  }
}
