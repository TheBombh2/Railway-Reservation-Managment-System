
import 'package:employee_frontend/ui/shared_features/appraisals/bloc/appraisals_bloc.dart';
import 'package:employee_frontend/ui/shared_features/appraisals/widgets/appraisal_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppraisalsList extends StatelessWidget {
  const AppraisalsList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppraisalsBloc, AppraisalsState>(
      listener: (context, state) {
        if (state is AppraisalsError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        if (state is AppraisalsLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is AppraisalsLoaded) {
          return ListView.builder(
            itemCount: state.list.size,
            itemBuilder: (ctx, index) {
              return AppraisalItem(
                appraisal: state.list.appraisals![index],
              );
            },
          );
        }
        return const Center(
          child: Text("No appraisals found"),
        );
      },
    );
  }
}
