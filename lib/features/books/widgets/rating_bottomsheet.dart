import 'dart:developer';

import 'package:assesment_elt/core/constants/app_colors.dart';
import 'package:assesment_elt/core/services/rating_service.dart';
import 'package:assesment_elt/core/services/session_service.dart';
import 'package:assesment_elt/core/services/user_data.dart';
import 'package:assesment_elt/core/util/responsive_helper.dart';
import 'package:assesment_elt/features/books/widgets/star_rating.dart';
import 'package:flutter/material.dart';

class RatingBottomSheet extends StatefulWidget {
  final String bookId;
  const RatingBottomSheet({super.key, required this.bookId});

  @override
  _RatingBottomSheetState createState() => _RatingBottomSheetState();
}

class _RatingBottomSheetState extends State<RatingBottomSheet> {
  int rating = 0;
  bool isLoading = false;

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
              color: AppColors.textGrey,
              borderRadius: BorderRadius.circular(2.5),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "Add rating",
            style: TextStyle(
              fontSize: ResponsiveHelper.getTextSize(context, scale: 0.04),
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
                onPressed: isLoading
                    ? null
                    : () async {
                        setState(() {
                          isLoading = true; // Start loading
                        });
                        String jwtToken =
                            await SecureStorageService.getAccessToken() ?? '';

                        if (jwtToken.isNotEmpty) {
                          final result = await RatingService.addRating(
                            bookId: widget.bookId,
                            rating: rating,
                            jwtToken: jwtToken,
                          );

                          if (result['statusCode'] == 200) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Rating added successfully!"),
                                backgroundColor: Colors.green,
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("${result['message']}"),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }

                          Navigator.pop(
                              context); // Go back after showing the snackbar
                        } else {
                          log("JWT token is missing.");

                          // Show a snackbar if the token is missing
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text("Session expired. Please log in again."),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                        setState(() {
                          isLoading = false; // Stop loading
                        });
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryOrange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: isLoading
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : Text(
                        "Submit",
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: ResponsiveHelper.getTextSize(context,
                              scale: 0.04),
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
