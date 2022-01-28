import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean1/future/domain/entities/peson_entity.dart';
import 'package:flutter_clean1/future/presentation/bloc/person_list_cubit/person_list_cubit.dart';
import 'package:flutter_clean1/future/presentation/bloc/person_list_cubit/person_list_state.dart';

import 'person_card_widget.dart';

class PersonsList extends StatelessWidget {
  PersonsList({Key? key}) : super(key: key);
  final scrollController = ScrollController();

  void setupScrollController(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          context.read<PersonListCubit>().loadPerson();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    setupScrollController(context);
    bool isLoading = false;

    return BlocBuilder<PersonListCubit, PersonState>(
      builder: (context, state) {
        List<PersonEntity> persons = [];
        if (state is PersonLoading && state.isFirstFetch!) {
          return _loadingIndicator();
        } else if (state is PersonLoading) {
          persons = state.oldPersonsList!;
          isLoading = true;
        } else if (state is PersonLoaded) {
          persons = state.personsList!;
        } else if (state is PersonError) {
          return Text(state.message!);
        }
        return ListView.separated(
            controller: scrollController,
            itemBuilder: (context, index) {
              if (index < persons.length) {
                return PersonCard(person: persons[index]);
              } else {
                return _loadingIndicator();
              }
            },
            separatorBuilder: (contex, index) {
              return const Divider(
                color: Colors.grey,
              );
            },
            itemCount: persons.length + (isLoading ? 1 : 0));
      },
    );
  }

  Widget _loadingIndicator() {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
