import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tic_tac_toe/Ui/thems/color.dart';

import 'Utils/game__logic.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String lastValue = "X";
  int gameOver = 0;
  int CountO = 0;
  int CountX = 0;
  int turn = 0;
  String res = "";
  bool isRepeat = false;
  List<int> scoreboard = [0,0,0,0,0,0,0,0];

  Game game = Game();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    game.board = Game.initGameBoard();
    print(game.board);
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
       backgroundColor: MainColor.primaryColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top:25.0),
              child: Text("It's ${lastValue} turn".toUpperCase(),
              style: TextStyle(
                fontSize: 58,
                color: Colors.white
              ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                children: [
                  Spacer(flex: 1,),
                  Text("O : ${CountO}",
                    style: TextStyle(
                        fontSize: 40,
                        color: Colors.white
                    ),
                  ),
                  Spacer(flex: 7,),
                  Text("X : ${CountX}",
                    style: TextStyle(
                        fontSize: 40,
                        color: Colors.white
                    ),
                  ),
                  Spacer(flex: 1,),
                ],
              ),
            ),
            Container(
              width: 400.0,
              height: 400.0,
              child: GridView.count(crossAxisCount: Game.boardlength ~/3,
                padding: EdgeInsets.all(16.0),
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                children: List.generate(Game.boardlength, (index){
                return InkWell(
                  onTap: gameOver != 0? null: (){
                    if(game.board![index] == ""){
                      setState(() {
                        game.board![index] = lastValue;
                        turn++;
                        gameOver = game.winnerCheck(lastValue, index, scoreboard, 3);
                        if(gameOver == 1 ||gameOver == 2 ){
                          // showDialog<String>(context: context,
                          //     builder: (BuildContext context) => AlertDialog(
                          //       title: Text("The Winner"),
                          //       content: Text("$lastValue is the Winner"),
                          //     ),
                          // );
                          Timer(Duration(seconds: 2), () {
                            print("$lastValue is the Winner");
                          });
                          if(gameOver == 1) {
                            CountX++;
                          }
                          else if(gameOver == 2)
                          {
                            CountO++;
                          }
                          game.board = Game.initGameBoard();
                          gameOver = 0;
                          turn = 0;
                          res = "";
                          scoreboard = [0,0,0,0,0,0,0,0];
                          if(isRepeat)
                            {
                              lastValue = "X";
                              isRepeat = false;
                            }
                          else{
                            lastValue = "O";
                            isRepeat = true;
                          }
                        }
                        else if(turn == 9){
                          Timer(Duration(seconds: 2), () {
                            print("It's Draw");
                          });
                          game.board = Game.initGameBoard();
                          gameOver = 0;
                          turn = 0;
                          res = "";
                          scoreboard = [0,0,0,0,0,0,0,0];
                          if(isRepeat)
                          {
                            lastValue = "X";
                            isRepeat = false;
                          }
                          else{
                            lastValue = "O";
                            isRepeat = true;
                          }
                        }
                        else{
                          if(lastValue == "X")
                            lastValue = "O";
                          else
                            lastValue = "X";

                        }
                      });
                    }
                  },
                  child: Container(
                    width: Game.blockSize,
                    height: Game.blockSize,
                    decoration: BoxDecoration(
                      color: MainColor.secondaryColor,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Center(
                      child: Text(game.board![index], style: TextStyle(
                        color: game.board![index] == "X"?
                        Colors.blue:
                        Colors.pink,
                        fontSize: 50.0,
                      ),
                      ),
                    ),
                  ),
                );
              }),
              ),
            ),
           IconButton(onPressed: (){
             setState(() {
               game.board = Game.initGameBoard();
               lastValue = "X";
               gameOver = 0;
               turn = 0;
               res = "";
               scoreboard = [0,0,0,0,0,0,0,0];
               CountO = CountX = 0;
             });
           },
             icon: Icon(Icons.replay,
             ),
             color: MainColor.accentColor,
               ),
          ],
        ),
      ),
    );
  }
}
