# for Dotinstall lessons

現在は公式を利用すべき。

- [dotinstallres/centos65: Setup CentOS6.5 environment for dotinstall lessons](https://github.com/dotinstallres/centos65)

詳細は[ドットインストールのレッスン向けの公式 Vagrant 環境が便利そう | deadwood](http://www.d-wood.com/blog/2016/06/27_8203.html)を参照のこと。

----

> * [ローカル開発環境の構築 (全12回) - プログラミングならドットインストール](http://dotinstall.com/lessons/basic_local_development_v2)

## VagrantとVirtualBoxのインストール

公式からパッケージをインストールします。

> * [Vagrant](http://www.vagrantup.com/)
> * [Oracle VM VirtualBox](https://www.virtualbox.org/)

バージョンは以下の通り。

```
% vagrant --version
Vagrant 1.3.1

% VirtualBox --help
Oracle VM VirtualBox Manager 4.2.18
(C) 2005-2013 Oracle Corporation
All rights reserved.
```

## 仮想マシン Box(テンプレート)を取得する

ドットインストールで使われているCentOSのBoxを取得する。

> * [A list of base boxes for Vagrant - Vagrantbox.es](http://www.vagrantbox.es/)

```
% vagrant box add centos64 \
    http://developer.nrel.gov/downloads/vagrant-boxes/CentOS-6.4-x86_64-v20130427.box
```

## dotinstall_box

```
vagrant up
vagrant package
vagrant box add dotinstall_box package.box
rm package.box
```


## 補遺

- [Vagrant: ドットインストールの開発環境構築レッスンをベースにWordPress環境をProvisioningしてみた](https://gist.github.com/DriftwoodJP/6694891)
