// class OrderModel {
//   late int id;
//   late int userId;
//   double? orderAmount;
//   String? orderStatus;
//   String? paymentStatus;
//   double? totalTaxAmount;
//   String? orderNote;
//   String? createdAt;
//   String? updatedAt;
//   double? deliveryCharge;
//   String? accepted;
//   String? confirmed;
//   String? processing;
//   String? handover;
//   String? pickedUp;
//   String? delivered;
//   String? canceled;
//   String? refundRequested;
//   String? refunded;
//   String? failed;
//   int? detailsCount;
//
//
//   OrderModel(
//       { required this.id,
//         required this.userId,
//         this.orderAmount,
//         this.paymentStatus,
//         this.orderNote,
//         this.createdAt,
//         this.updatedAt,
//         this.deliveryCharge,
//         this.orderStatus,
//         this.accepted,
//         this.confirmed,
//         this.processing,
//         this.handover,
//         this.pickedUp,
//         this.delivered,
//         this.canceled,
//         this.failed,
//         this.detailsCount,
//       });
//
//   OrderModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     userId = json['user_id'];
//     orderAmount = json['order_amount'].toDouble();
//     paymentStatus = json['payment_status']??"pending";
//     totalTaxAmount =10.0;
//     orderNote = json['order_note'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     orderStatus=json['order_status'];
//     deliveryCharge = 10.0;
//     accepted = json['accepted']??"";
//     confirmed = json['confirmed']??"";
//     processing = json['processing']??"";
//     handover = json['handover']??"";
//     pickedUp = json['picked_up']??"";
//     delivered = json['delivered']??"";
//     canceled = json['canceled']??"";
//     failed = json['failed']??"";
//     detailsCount = json['details_count'];
//
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['user_id'] = userId;
//     data['order_amount'] = orderAmount;
//
//     data['payment_status'] = paymentStatus;
//     data['total_tax_amount'] = totalTaxAmount;
//     data['order_note'] = orderNote;
//     data['created_at'] = createdAt;
//     data['updated_at'] = updatedAt;
//     data['delivery_charge'] = deliveryCharge;
//     data['accepted'] = accepted;
//     data['confirmed'] = confirmed;
//     data['processing'] = processing;
//     data['handover'] = handover;
//     data['picked_up'] = pickedUp;
//     data['delivered'] =delivered;
//     data['canceled'] = canceled;
//     data['refund_requested'] = refundRequested;
//     data['refunded'] = refunded;
//     data['failed'] = failed;
//     data['details_count'] =detailsCount;
//     return data;
//   }
// }