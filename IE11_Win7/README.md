# IE11 - Win7

IE の表示テスト環境を構築する。

* 最新の IE11 をインストール。
* Developer Toolsの「BrowserMode」「Document Mode」を利用して、IE7から10をまかなう。


## Require

* [Oracle VM VirtualBox](https://www.virtualbox.org/)




## セットアップ

Modern.IE ファイルのダウンロードと、VirtualBox への登録、スナップショットの作成を行う。

```
% ./setup.sh
```

※ 実行前にダウンロード対象が最新であるかを Modern.IE で確認すること。

> * [Virtual Machine (VM), Windows Virtual PC & Browserstack | Modern.IE](http://www.modern.ie/en-us/virtualization-tools#downloads)


### 日本語入力の設定

仮想マシンの起動後、コントロールパネルから言語を追加する。

* 「Setting」→「Control Panel」→「Add language」で日本語を選択。




## 参考

* [MacにIEテスト環境を作る（VirtualBox 編） | deadwood](http://www.d-wood.com/blog/2014/01/27_5343.html)
* [MacにIEテスト環境を作る（ievms 編） | deadwood](http://www.d-wood.com/blog/2014/04/24_6085.html)
* [VirtualBox: VBoxManage を使って VM の登録と snapshot をとる | deadwood](http://www.d-wood.com/blog/2014/04/26_6097.html)
