class PaymentModel{
   final String linkImage;
   final String titlePayment;
   bool selected;
   bool indexBank;

  PaymentModel({required this.linkImage,required  this.titlePayment, this.selected = false, this.indexBank = false});
}