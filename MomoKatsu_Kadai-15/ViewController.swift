//
//  ViewController.swift
//  MomoKatsu_Kadai-15
//
//  Created by モモカツ on 2023/07/17.

import UIKit

class ViewController: UIViewController {

    // テーブルビューとのインスタンス変数設定
    @IBOutlet weak var tableView: UITableView!

    // 構造体を設定
    struct ItemValue {
        var name: String
        var check: Bool
    }
    // 表示する値を構造体で設定
    var selectItems:[ItemValue] = []

     override func viewDidLoad() {
        super.viewDidLoad()
        // テーブルビュー表示内容
        selectItems = [
            ItemValue(name: "りんご", check: false),
            ItemValue(name: "みかん", check: true),
            ItemValue(name: "バナナ", check: false),
            ItemValue(name: "パイナップル", check: true),
        ]
    }

    @IBAction func inputNameTextField(unwindSegue: UIStoryboardSegue) {

        guard let addEditItemVC = unwindSegue.source as? AddItemViewController else { return }

        // AddItemViewController で追加した内容を表示
        print("追加内容：'", addEditItemVC.inputName  ?? "", "'")

        // 追加した内容を構造体へ追加
        selectItems.append(ItemValue(name: addEditItemVC.inputName ?? "", check: false))
        //print("追加入力後のデータ個数：", selectItems.count)
        //print(selectItems)

        //テーブルを再描画
        tableView.reloadData()
    }

}

// ストリーボードの TableView と ViewController を Delegate で紐付けするが必要。
extension ViewController: UITableViewDataSource, UITableViewDelegate {

    // テーブルビューに表示するデータを返すメソッド（スクロールなどでページを更新する必要が出るたびに呼び出される）
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        //セルを取得する
        let cell = UITableViewCell(style: .default, reuseIdentifier: "selectCell")

        // チェックマークを"true"の場合付ける
        if selectItems[indexPath.row].check {
            cell.imageView!.image = UIImage(named: "check")
        } else {
            cell.imageView!.image = UIImage(named: "nocheck")
        }

        cell.textLabel!.text = selectItems[indexPath.row].name
        return cell
    }

    // テーブルビューに表示するデータ個数を返すメソッド
    func tableView(_ tableView: UITableView, numberOfRowsInSection section:Int) -> Int {
        //print("データ個数：", selectItems.count)
        return selectItems.count
    }

    // didSelectRowAtでセルがタップされた時の処理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        // チェックマークを反転
        selectItems[indexPath.row].check = !selectItems[indexPath.row].check
        print("チェックマーク：", selectItems[indexPath.row].check, ",   名 前：", selectItems[indexPath.row].name)

        // TableView の特定の行だけをリロード
        self.tableView.reloadRows(at: [indexPath], with: .fade)//automatic) .none)

    }

}
