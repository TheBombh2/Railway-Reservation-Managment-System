
import 'package:employee_frontend/ui/shared_features/citations/bloc/citations_bloc.dart';
import 'package:employee_frontend/ui/shared_features/citations/widgets/citation_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CitationsList extends StatelessWidget {
  const CitationsList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CitationsBloc, CitationsState>(
      listener: (context, state) {
        if (state is CitationsError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        if (state is CitationsLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is CitationsLoaded) {
          return ListView.builder(
            itemCount: state.list.size,
            itemBuilder: (ctx, index) {
              return CitationItem(
                citation: state.list.citations![index],
              );
            },
          );
        }
        return const Center(
          child: Text("No Citations found"),
        );
      },
    );
  }
}
