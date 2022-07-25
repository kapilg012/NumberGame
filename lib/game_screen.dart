import 'package:flutter/material.dart';
import 'package:number_game/player_add_screen.dart';
import 'package:number_game/player_model.dart';
import 'alert_dialogue.dart';
import 'numberGainingAlert.dart';

class GameScreen extends StatefulWidget {
  List<Player>? listOfPlayer;

  GameScreen(this.listOfPlayer, {Key? key}) : super(key: key);

  @override
  GameScreenState createState() => GameScreenState();
}

class GameScreenState extends State<GameScreen> {
  List<Player>? listOfPlayers = [];
  var turn = 0;
  List<double> listOfMagic = [
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0
  ];
  TextEditingController controller = TextEditingController();
  List<bool> listOfSelecedNumbers = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listOfPlayers = widget.listOfPlayer;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Number Game"),
      ),
      body: getMainlayout,
    );
  }

  get getMainlayout => SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              getGrid,
              getChalBoard,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  getResetButton,
                  getLoser,
                ],
              ),
            ],
          ),
        ),
      );

  get getGrid => GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.listOfPlayer?.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (ctx, index) {
        return getSingleItem(index);
      });

  getSingleItem(index) {
    return InkWell(
      onTap: () {
        setState(() {
          turn = index;
        });
        if (listOfPlayers?[index].number == 0) {
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              backgroundColor: Colors.transparent,
              contentPadding: const EdgeInsets.only(right: 25, left: 25),
              content: NumberGainingAlert(listOfPlayers?[index].name ?? ""),
            ),
          ).then((value) {
            if (value != 0 && value != null) {
              setState(() {
                listOfPlayers?[index].number = value;
              });
            }
          });
        }
      },
      child: Container(
        decoration: BoxDecoration(
            color: (listOfPlayers![index].hasWon) ? Colors.green : Colors.red,
            border: Border.all(
                width: 5, color: (turn == index) ? Colors.black : Colors.grey)),
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Text(
              listOfPlayers![index].name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Text(
              (listOfPlayers![index].number == 0) ? "-" : "**",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            Container(
              //padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: (listOfPlayers?[index].hasWon ?? true)
                      ? Colors.black
                      : Colors.white),
              child: Text(
                (listOfPlayers?[index].hasWon ?? false)
                    ? "Winner: ${listOfPlayers?[index].number}"
                    : "",
                style: const TextStyle(color: Colors.orange, fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }

  get getChalBoard => Container(
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              "${listOfPlayers?[turn].name}'s Turn",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(
              height: 20,
            ),
            GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 20,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5),
                itemBuilder: (ctx, index) {
                  return singleNumber(index);
                })
          ],
        ),
      );

  singleNumber(index) {
    return InkWell(
      onTap: () {
        if (!listOfSelecedNumbers[index]) {
          var isZero = false;
          listOfPlayers?.forEach((element) {
            if (element.number == 0) {
              isZero = true;
            }
          });

          if (!isZero &&
              !listOfPlayers![turn].hasWon &&
              listOfPlayers![turn].number != index + 1) {
            setState(() {
              for (int i = 0; i < listOfPlayers!.length; i++) {
                if (listOfPlayers?[i].number == (index + 1)) {
                  listOfPlayers?[i].hasWon = true;
                }
              }

              listOfSelecedNumbers[index] = true;
            });
          }
          if (listOfPlayers![turn].number != index + 1) {
            setState(() {
              getTurnRight();
            });
          }
        }
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: (listOfSelecedNumbers[index]) ? Colors.grey : Colors.orange,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.black)),
        child: Center(
          child: Text(
            "${index + 1}",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color:
                    (listOfSelecedNumbers[index]) ? Colors.grey : Colors.black),
          ),
        ),
      ),
    );
  }

  get getResetButton => InkWell(
        onTap: () {
          setState(() {
            for (int i = 0; i < listOfPlayers!.length; i++) {
              listOfPlayers?[i].hasWon = false;
              listOfPlayers?[i].number = 0;
            }
            listOfSelecedNumbers = [
              false,
              false,
              false,
              false,
              false,
              false,
              false,
              false,
              false,
              false,
              false,
              false,
              false,
              false,
              false,
              false,
              false,
              false,
              false,
              false,
            ];
            listOfMagic = [
              0,
              0,
              0,
              0,
              0,
              0,
              0,
              0,
              0,
              0,
              0,
              0,
              0,
              0,
              0,
              0,
              0,
              0,
              0,
              0
            ];
            turn = 0;
          });
        },
        child: Container(
          height: 40,
          width: 100,
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(color: Colors.grey),
          child: const Center(
            child: Text(
              "RESET",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black),
            ),
          ),
        ),
      );

  get getLoser => InkWell(
        onTap: () {
          var flag = false;
          listOfSelecedNumbers.forEach((element) {
            if (element) {
              flag = true;
            }
          });
          if (flag){
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                backgroundColor: Colors.transparent,
                contentPadding: const EdgeInsets.only(right: 25, left: 25),
                content: AlertDialogueScreen(),
              ),
            ).then((value) {
              if (value) {
                PlayerAddScreen.listOfPlayerScore[turn]++;
              }
            });
          }
        },
        child: Container(
          height: 40,
          width: 100,
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(color: Colors.grey),
          child: const Center(
            child: Text(
              "LOSER",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black),
            ),
          ),
        ),
      );

  getTurnRight() {
    if (turn == (listOfPlayers!.length) - 1) {
      turn = 0;
      var flag = true;
      listOfPlayers?.forEach((element) {
        if (!element.hasWon && flag) {
          turn = listOfPlayers?.indexOf(element) ?? 0;
          flag = false;
        }
      });
    } else {
      var flag = true;
      turn = turn + 1;
      for (int i = 0; i < listOfPlayers!.length; i++) {
        if (turn <= i && flag) {
          if (!listOfPlayers![i].hasWon) {
            turn = i;
            flag = false;
          }
        }
      }
      if (flag) {
        turn = 0;
        var flag2 = true;
        listOfPlayers?.forEach((element) {
          if (!element.hasWon && flag2) {
            turn = listOfPlayers?.indexOf(element) ?? 0;
            flag2 = false;
          }
        });
      }
    }
  }
}
