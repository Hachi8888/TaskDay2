//
//  ViewController.swift
//  NumbersGame
//
//  Created by VERTEX22 on 2019/08/06.
//  Copyright © 2019 N-project. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

// ★ラベル系の紐付け一覧
    
    /* ①デフォルトで「??」を表示
       ②入力すると入力した数字を表示するラベル*/
    @IBOutlet weak var showNumber: UILabel!

    // 回答を記入するラベル
    @IBOutlet weak var inputFeild: UITextField!
    
    // 回答に対するコメントを記載&追加していくラベル(下方)
    @IBOutlet weak var showComment: UITextView!
    
    
// ★共通で使う定数、変数
    
    // 乱数が入っている変数
    var questionNum: Int = Int.random(in: 0...100)
    
    // 問題数をカウントする変数
    var count: Int = 0
    
    
// 画面が読み込まれたときの処理
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        // showCommentをユーザー側で編集不可にする
        showComment.isEditable = false
        
        
    }
    
// ★考え方★
// 画面が読み込まれたとき、ランダムな数値を1〜100で生成する(ViewDidLoadに書く!)
// 解答欄に回答を記入する
// 決定ボタンを押す(Button)
//showNumberラベル(デフォルト:??)にランダムな数字が表示される
// アラートで結果が表示される
// 結果は下方のテキスト欄(showComment)に記載される(回数付き)
    
    
    
 // ★関数欄★

    @IBAction func Button(_ sender: Any) {
        
        // ボタン(Button)を押したときの処理
        
        // ①問題数を進める
          count += 1
        
        // ②入力チェック(回答はInt型か)
        /* キャストするときにInt()とする場合と as? Int とする場合の違いが不明。。
           今回はInt()としないとエラーとなる↓ */
        if let yourAnswer: Int = Int(inputFeild.text!) {
            
            // Int型の回答の場合
            // ③回答の正否を判定する
            if yourAnswer == questionNum {
            
                // 正解
                // 正解コメントをアラートする(改行は\n?、動作未確認)
                showAlert(message: "\(count)回目で正解しました!\n数字をリセットしました!", title: "正解")
                
             //showCommentラベルにアラート内容を追加して表示する
                showComment.text += "[正解]答えは\(yourAnswer)でした!\n"
                
                
                // showNumberラベルをデフォルト:??に戻す(動作未確認)
                 showNumber.text = "??"
                
                
                // 乱数をリセットする(動作未確認)
                questionNum = Int.random(in: 0...100)
                
                // 問題のカウントをリセットする
                   count = 0
                
            } else if yourAnswer > questionNum {
                
                // 不正解:正解よりも回答が大きい場合
                // 不正解コメント(ヒント)をアラートする
                
                showHint(yourAnswer: yourAnswer)
                
            //showCommentラベルにアラート内容を追加して表示する
                showComment.text += "[\(count)回目]答えは\(yourAnswer)より小さいです\n"
                
                
            } else if yourAnswer < questionNum {       // 不正解:正解よりも回答が小さい場合
                // 不正解コメント(ヒント)をアラートする
                
                showHint(yourAnswer: yourAnswer)
                
            //showCommentラベルにアラート内容を追加して表示する
                showComment.text += "[\(count)回目]答えは\(yourAnswer)より大きいです\n"
                
                
                
                
            }
            
        // ④showNumberラベル(デフォルト:??)に入力した数字を表示する
        // yourAnswer をString型にキャストした
            showNumber.text = String(yourAnswer)
            
            
        } else{
           // Int型以外の入力の場合
            showAlert(message: "数字を入力してください", title: "")
        
        }
        
    }
    


    // アラートを出す関数:showAlert(不正解の場合or数値以外が入力された場合)
    
    func showAlert(message: String, title: String){
        //アラートの作成
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        //アラートのアクション(ボタンの定義)
        let close = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        //作成したalertに閉じるボタンを追加
        alert.addAction(close)
        //アラートを表示する
        present(alert, animated: true, completion: nil)
    }
    
    
    
    // 不正解コメント(ヒント)を表示する関数
    
    func showHint(yourAnswer: Int){
        // 回答が正解よりも大きい場合
        if yourAnswer > questionNum {
            showAlert(message: "答えは\(yourAnswer)より小さい数字です", title: "")
        } else if yourAnswer < questionNum {
        // 回答が正解よりも小さい場合
            showAlert(message: "答えは\(yourAnswer)より大きい数字です", title: "")
            
        }
    }
    

    



}
