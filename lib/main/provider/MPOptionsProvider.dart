


import 'package:klik/main/models/MPOptionsModel.dart';

List<PaymentOptions> getCardType() {
  List<PaymentOptions> optionsList = [];

  optionsList.add(PaymentOptions('assets/images/masterCard.png', 'Master Card', 'endWiths 8793', ''));
  optionsList.add(PaymentOptions('assets/images/visaCard.png', 'Visa Card', 'endWiths 8793', 'set as default'));

  return optionsList;

}