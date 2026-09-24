// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class CustomCartItem extends StatelessWidget {
//   const CustomCartItem({
//     super.key,
//     required this.image,
//     required this.title,
//     required this.rating,
//     required this.price,
//     required this.oldPrice,
//     required this.quantity,

//     this.onIncrement,
//     this.onDecrement,
//     required this.productId,
//     required this.needButton,
//   });

//   final String image;
//   final String title;
//   final double rating;
//   final double price;
//   final double oldPrice;
//   final int quantity;
//   final int productId;
//   final VoidCallback? onIncrement;
//   final VoidCallback? onDecrement;
//   final bool needButton;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 331.w,
//       color: Colors.white,
//       child: Column(
//         children: [
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   width: 130.53.w,

//                   clipBehavior: Clip.antiAlias,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(8.r),
//                   ),

//                   child: Image.network(image, fit: BoxFit.cover),
//                 ),

//                 SizedBox(width: 6.w),

//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         title,
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                         style: TextStyle(
//                           fontSize: 14.sp,
//                           fontWeight: AppTextStyle.semiBold,
//                           color: Colors.black,
//                         ),
//                       ),

//                       SizedBox(height: 12.h),

//                       Row(
//                         children: [
//                           Text(
//                             rating.toString(),
//                             style: TextStyle(
//                               fontSize: 12.sp,
//                               fontWeight: AppTextStyle.medium,
//                             ),
//                           ),
//                           SizedBox(width: 3.w),
//                           const Icon(Icons.star, color: Colors.amber, size: 15),
//                         ],
//                       ),

//                       SizedBox(height: 14.h),

//                       Row(
//                         children: [
//                           Text(
//                             '\$ ${price.toStringAsFixed(2)}',
//                             style: TextStyle(
//                               fontSize: 16.sp,
//                               fontWeight: AppTextStyle.semiBold,
//                             ),
//                           ),
//                           SizedBox(width: 6.w),
//                           Text(
//                             '\$ ${oldPrice.toStringAsFixed(2)}',
//                             style: TextStyle(
//                               decoration: TextDecoration.lineThrough,
//                               color: Colors.grey,
//                               fontSize: 14.sp,
//                             ),
//                           ),
//                         ],
//                       ),

//                       SizedBox(height: 14.h),

//                       needButton
//                           ? Align(
//                               alignment: Alignment.centerRight,
//                               child: Row(
//                                 children: [
//                                   Spacer(),
//                                   GestureDetector(
//                                     onTap: onDecrement,
//                                     child: Container(
//                                       width: 24.sp,
//                                       height: 24.sp,
//                                       decoration: BoxDecoration(
//                                         color: AppColors.darkNav,
//                                         borderRadius: BorderRadius.circular(
//                                           5.r,
//                                         ),
//                                       ),
//                                       child: Icon(
//                                         Icons.remove,
//                                         color: AppColors.white,
//                                       ),
//                                     ),
//                                   ),
//                                   SizedBox(width: 10.w),
//                                   Text(
//                                     '$quantity',
//                                     style: TextStyle(
//                                       fontSize: 24.43.sp,
//                                       fontWeight: AppTextStyle.regular,
//                                       color: Color(0xFF391713),
//                                     ),
//                                   ),
//                                   SizedBox(width: 10.w),
//                                   GestureDetector(
//                                     onTap: onIncrement,
//                                     child: Container(
//                                       width: 24.sp,
//                                       height: 24.sp,
//                                       decoration: BoxDecoration(
//                                         color: AppColors.primary,
//                                         borderRadius: BorderRadius.circular(
//                                           5.r,
//                                         ),
//                                       ),
//                                       child: Icon(
//                                         Icons.add,
//                                         color: AppColors.white,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             )
//                           : SizedBox(),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           const Divider(color: Color(0xffBBBBBB), height: 1),

//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
//             child: Row(
//               children: [
//                 Text(
//                   'Total Order ($quantity)  :',
//                   style: TextStyle(
//                     fontSize: 12.sp,
//                     fontWeight: AppTextStyle.medium,
//                     color: AppColors.black,
//                   ),
//                 ),

//                 const Spacer(),

//                 Text(
//                   '\$ ${price.toStringAsFixed(2)}',
//                   style: TextStyle(
//                     fontSize: 12.sp,
//                     fontWeight: AppTextStyle.semiBold,
//                     color: AppColors.black,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
