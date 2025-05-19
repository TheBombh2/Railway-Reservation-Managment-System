
import 'package:customer_frontend/ui/reservations/bloc/reservation_bloc.dart';
import 'package:customer_frontend/ui/reservations/widgets/reservation_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppraisalsList extends StatelessWidget {
  const AppraisalsList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ReservationsBloc, ReservationsState>(
      listener: (context, state) {
        if (state is ReservationsError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        if (state is ReservationsLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is ReservationsLoaded) {
          return ListView.builder(
            itemCount: state.list.size,
            itemBuilder: (ctx, index) {
              return ReservationItem(
                reservation: state.list.reservations![index],
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
