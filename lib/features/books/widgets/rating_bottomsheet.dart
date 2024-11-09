import 'package:assesment_elt/core/services/session_service.dart';
import 'package:assesment_elt/core/util/responsive_helper.dart';
import 'package:assesment_elt/features/books/widgets/star_rating.dart';
import 'package:flutter/material.dart';

class RatingBottomSheet extends StatefulWidget {
  const RatingBottomSheet({super.key});

  @override
  _RatingBottomSheetState createState() => _RatingBottomSheetState();
}

class _RatingBottomSheetState extends State<RatingBottomSheet> {
  double rating = 0.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 8),
          Container(
            width: 50,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2.5),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "Add rating",
            style: TextStyle(
              fontSize: ResponsiveHelper.getTextSize(context, scale: 0.05),
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          StarRating(
            rating: rating,
            width: ResponsiveHelper.getWidth(context),
            onRatingChanged: (newRating) {
              setState(() {
                rating = newRating;
              });
            },
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  String userId = await UserSessionService.getUserId() ?? '';
                  print(userId);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  "Submit",
                  style: TextStyle(
                    fontSize:
                        ResponsiveHelper.getTextSize(context, scale: 0.04),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
