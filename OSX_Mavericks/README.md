# OS X Mavericks

OS X Mavericks のテスト環境を構築する。


## Require

* [Oracle VM VirtualBox](https://www.virtualbox.org/)
* [ntkme/iesd](https://github.com/ntkme/iesd)


## Setup

### OS X インストーラをダウンロードする

AppStore.app から、Mavericks のインストーラをダウンロードします。
ダウンロード終了後、インストーラが立ち上がりますが、そのまま何もせずに終了します。


iesd をインストールする

```
% bundle install --path vendor/bundle
```

インストールディスクを作成する

```
% iesd -i /Applications/Install\ OS\ X\ Mavericks.app -o Mavericks.dmg -t BaseSystem
```

作成された `Mavericks.dmg` を VirtualBox へインストールする。



## 参考

> * [VirtualBox: guest OS に OS X Mavericks (10.9) をインストールする | deadwood](http://www.d-wood.com/blog/2014/03/24_5880.html)
