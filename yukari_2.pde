/*
Reference Documentation:
http://d.hatena.ne.jp/kougaku-navi/20111202/p1
https://msdn.microsoft.com/en-us/library/dd375731.aspx

This program need eclipse found in http://eclipse.org/swt/ Releases->Stable->
And unzip the files , put them in *\Processing\libraries
please change your input method to japanese in voiceroid's window
If any problem  , you can contact me by Gmail(aeonsiegfried@gmail.com) or use Plurk (http://www.plurk.com/imdinosaur)

I can respond with chinese , japenese , and english.
*/

import org.eclipse.swt.internal.win32.*;
import java.nio.charset.Charset;

void setup() {
  size(400,300);  
  
}

void draw() { 
  String yukari_voice;
  //yukari_voice = yukari_Timekeeping();
  //yukari_voice =  read_now_time();
  yukari_voice = "HELLO WORLD";
  Charset.forName("ISO8859-1").encode(yukari_voice);   // しゃべらせるデータ
  voiceroid_talk(yukari_voice);
  delay( yukari_voice.length() * 300 );              // しゃべり終わるまで適当に待つ

}

void voiceroid_talk(String voice_text) {
  // ウィンドウ名からハンドルを取得
  int hWnd = OS.FindWindow(null, new TCHAR(OS.CP_INSTALLED, "voiceroid＋ 結月ゆかり",true));  
             OS.SetForegroundWindow(hWnd);

  int second = OS.GetWindow(hWnd, OS.GW_CHILD);
  int third = OS.GetWindow(second, OS.GW_CHILD);
  int handle_buttons = OS.GetWindow(third, OS.GW_HWNDNEXT);
  int handle_registor_word_button = OS.GetWindow(handle_buttons, OS.GW_CHILD);
  int handle_phrase_adjust_button = OS.GetWindow(handle_registor_word_button ,OS.GW_HWNDNEXT);
  int handle_save_button = OS.GetWindow(handle_phrase_adjust_button ,OS.GW_HWNDNEXT);
  int handle_stop_button = OS.GetWindow(handle_save_button ,OS.GW_HWNDNEXT);
  int handle_play_button = OS.GetWindow(handle_stop_button ,OS.GW_HWNDNEXT);
  

  //voiceroid＋ 結月ゆかり
  //print("hi");
  //hide voiceroid's window
  // VOICEROIDのウィンドウを隠したいなら
  // OS.SetWindowPos(hWnd,0,-1000,0,0,0,0);
   ArrayList list = new ArrayList();
  list.add(String.valueOf( OS.GetWindow(hWnd, OS.GW_CHILD) ));
  // テキスト領域（クラス名：TkChild）のハンドルを取得
    while (list.size() > 0) {
    int i = Integer.parseInt( list.get(list.size()-1).toString() );
    list.remove(list.size()-1);
    TCHAR buf = new TCHAR(OS.CP_INSTALLED, 256);
    OS.GetClassName(i, buf, 256);
    if (buf.toString(0, buf.strlen()).equals("TkChild")) {
      hWnd = i;
      break;
    }
        
    int c = OS.GetWindow(i, OS.GW_CHILD);
    if (c == 0) {
      int n = OS.GetWindow(i, OS.GW_HWNDNEXT);
      if (n == 0) {
        continue;
      } else {
        list.add(String.valueOf(n));
      }
    } else {
      int n = OS.GetWindow(i, OS.GW_HWNDNEXT);
      if (n != 0) list.add(String.valueOf(n));
      list.add(String.valueOf(c));
    }
   
  }
  
  /*
   WINDOWPLACEMENT wndpl = new WINDOWPLACEMENT();
   OS.GetWindowPlacement(hWnd, wndpl);
   wndpl.bottom -= 100;
   OS.SetWindowPlacement(hWnd, wndpl);
  */
    
  //OS.SendMessage(hWnd, OS.WM_KEYDOWN , OS.VK_CONTROL,  0);
  //OS.SendMessage(hWnd, OS.WM_KEYDOWN , 0x41,  0);
  
  //　清除殘留資料
    for (int i=0; i<(2*voice_text.length()); i++) {
    OS.SendMessage(hWnd, OS.WM_KEYDOWN, OS.VK_BACK, 0);
  }
    delay(100);
    println("CLEAR_TEXT");
    // キーコード送信  
  //print(voice_text);  
  //OS.SendMessage(hWnd, OS.WM_CHAR, OS.VK_JUNJA , 0);
      for (int i=0; i<voice_text.length(); i++) {
    OS.PostMessage(hWnd, OS.WM_CHAR, voice_text.charAt(i), 0);
    println("SendMessage-CHAR");
  //  println(voice_text.charAt(i));
            }
   //　　　命令播放
    OS.PostMessage(handle_play_button, 0, 0, 0);
    println("SendMessage-PLAY");
// 再生実行（F5キー送信）
//  OS.SendMessage(hWnd, OS.WM_KEYDOWN, OS.VK_F5, 0);
// OS.SendMessage(hWnd, OS.WM_MOUSEMOVE, 50 , 320); 
//  OS.SendMessage(hWnd, OS.WM_LBUTTONDOWN, OS.MK_LBUTTON , MAKELPARAM(0,0)); 
// delay(10); 
// OS.SendMessage(hWnd, OS.WM_LBUTTONUP, OS.MK_LBUTTON , MAKELPARAM(tx,ty));  
//     delay(5000); 
//  OS.SendMessage(TalkButton(), 0, IntPtr.Zero, IntPtr.Zero);
//OS.SendMessage(hWnd, OS.WM)
  
  // BackSpaceキー送信
  delay(150*voice_text.length());
  for (int i=0; i<(2*voice_text.length()); i++) {
    OS.SendMessage(hWnd, OS.WM_KEYDOWN, OS.VK_BACK, 0);
  }
  delay(2000);
  //　強制停止
  
    OS.SendMessage(handle_stop_button, 0, 0, 0);
  println("SendMessage-STOP");
    delay(100);
  } 
//　報現在時間
String read_now_time() 
{
  background(204);
  int s = second();  // Values from 0 - 59
  int m = minute();  // Values from 0 - 59
  int h = hour();    // Values from 0 - 23
// println(h , m , s);
  
  String sec = Integer.toString(s);
  String min = Integer.toString(m);  
  String hr = Integer.toString(h);
  String time = "現在時刻は" + hr + "時 " + min + "分 " +  sec + "秒です" ;
  println(time);
  return time;
}
//　整點報時
String yukari_Timekeeping()
{
String time_voice="";

  int s = second();  // Values from 0 - 59
  int m = minute();  // Values from 0 - 59
  int h = hour();    // Values from 0 - 23

if( m==0  && s< 10 )
{
  /*
  if (h == 22)
    {
  time_voice  = "午後10時です。あぁ～もう～っ、5500トン級が一隻ホントうるさいですね。文句言ってきましょうか。"  ;
  println(h+"報時");
  }
  
  if (h == 23)
  {
  time_voice  = "午後11時です。まだ頑張るんですね。じゃぁ、今晩もお付き合いします。"  ;
  println(h+"報時");
  }*/
   time_voice  =  "現在時刻　は　" + h + "　時　です";
  
  println(time_voice);
}
  delay(2000);
  return time_voice;
  
}


