import 'package:flutter/material.dart';
import 'package:tic_tac_toc/game_logic.dart';
import 'package:neon_widgets/neon_widgets.dart';
import 'package:flutter_glow/flutter_glow.dart';


class Home_page extends StatefulWidget {
  const Home_page({Key? key}) : super(key: key);

  @override
  State<Home_page> createState() => _Home_pageState();
}

class _Home_pageState extends State<Home_page> {
  int cnt =0;
  String player='X',result='';
  bool gameover=false;
  int turn = 0;
  Game game=Game();
  bool is_switch=false;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Column(
          children:
          [
            SwitchListTile.adaptive(
                title: Text(
                  !is_switch?'Computer Mode':'1V1 Mode',

                  style: TextStyle(
                    fontSize: 25.0,
                  ),
                  textAlign: TextAlign.center,
                ),
                value: is_switch,
                onChanged:(bool newval){
                  setState(() {
                    is_switch=newval;
                  });
                }
            ),
            SizedBox(height: 20.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
              [
                GlowText(
                  'O',
                  style: TextStyle(
                    fontSize: 60.0,
                    color: Colors.lightBlue,

                  ),
                  glowColor: Colors.red[100],
                ),
                SizedBox(width: 50.0,),
                GlowText(
                  ':',
                  style: TextStyle(
                    fontSize: 60.0,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 50.0,),
                GlowText(
                  'X',
                  style: TextStyle(
                    fontSize: 60.0,
                    color: Colors.pink,
                  ),
                  glowColor: Colors.red[100],

                ),
              ],
            ),
            SizedBox(height: 50.0,),




            Expanded(
                child: GridView.count(
                  padding: EdgeInsets.all(16.0),
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                  childAspectRatio: 1.0,
                  crossAxisCount:3,
                  children: List.generate(9, (index) => InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap:gameover?null: ()=>_onTab(index),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).splashColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: GlowText(
                          Player.playerX.contains(index)? 'X': Player.playerO.contains(index)? 'O':'',
                          style: TextStyle(
                            color: Player.playerX.contains(index)?Colors.pink: Colors.blue,
                            fontSize: 60.0,

                          ),
                          glowColor: Colors.red[100],
                        ),
                      ),
                    ),
                  )),
                )
            ),





            GlowText(
               '$result',
              style: TextStyle(
                color: cnt==1?Colors.pink: Colors.blue,
                fontSize: 50,

              ),
            ),



            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                  onPressed: (){
                    setState(() {
                       player='X';
                       result='';
                       gameover=false;
                       turn = 0;
                       Player.playerX.clear();
                       Player.playerO.clear();
                    });
                  },
                  icon: Icon(Icons.replay),
                  label: Text('REPLAY'),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Theme.of(context).splashColor),
                ),
              ),
            ),
          ],
        ),
      ),

    );
  }

  _onTab(int index) async {
    if((!Player.playerX.contains(index) && !Player.playerO.contains(index))){
      game.playgame(index,player);
      updatestate();
      if(!is_switch && !gameover && turn !=9   ){
        await game.autoplay(player);
        updatestate();
      }

    }

  }

  void updatestate(){
    setState(() {
      turn++;
      player=  (player=='X')?'O':'X';

      String res= game.CheckWinner();
      if(res!=''){
        if(res=='X'){
          cnt=1;
        }
        else{
          cnt=2;
        }
        gameover=true;
        result='$res is the winner';
      }
      else if(!gameover && turn ==9){
        result ='it\'s Draw';
      }

    });
  }





}
