// SingleChildScrollView(
// child: ListView.separated(
// shrinkWrap: true,
// itemBuilder: (BuildContext context, int index) =>
// GestureDetector(
// onTap: () {},
// child: Padding(
// padding: const EdgeInsets.symmetric(horizontal: 25),
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceAround,
// children: [
// Container(
// child: Row(
// children: [
// isCredit(
// '${transactionList[index].transType!}')
// ? Icon(
// Icons.add,
// size: 10,
// color: appGreenColor,
// )
// : Icon(
// Icons.remove,
// size: 10,
// color: appRedColor,
// ),
// Text(
// 'NGN ${transactionList[index].amount!}',
// style: TextStyle(
// fontSize: 14,
// color: isCredit(
// '${transactionList[index].transType!}')
// ? appGreenColor
//     : appRedColor),
// ),
// ],
// ),
// ),
// Expanded(
// child: Container(
// padding: EdgeInsets.only(left: 35),
// child: Column(
// crossAxisAlignment:
// CrossAxisAlignment.start,
// mainAxisAlignment:
// MainAxisAlignment.spaceAround,
// children: [
// Text(
// transactionList[index].date!,
// style: const TextStyle(fontSize: 14),
// ),
// ],
// ),
// ),
// ),
// Container(
// alignment: Alignment.centerLeft,
// child: Column(
// mainAxisAlignment:
// MainAxisAlignment.spaceAround,
// children: [
// Text(
// transactionList[index].status!,
// textAlign: TextAlign.left,
// style: TextStyle(
// fontSize: 14,
// color: isSuccessful(
// '${transactionList[index].status!}')
// ? appGreenColor
//     : appRedColor),
// ),
// ],
// ),
// ),
// ],
// ),
// 8.height,
// Row(
// children: [
// const Icon(
// Icons.location_on,
// size: 15,
// ),
// 8.width,
// Text(
// transactionList[index].location!,
// style: const TextStyle(fontSize: 10),
// ),
// ],
// ),
// ],
// ),
// ),
// ),
// separatorBuilder: (context, index) => const Divider(
// color: Colors.transparent,
// ),
// itemCount: transactionList.length))