1.1.1 プログラムの要素
(+ 137 349)

(- 1000 334)

(* 5 99)

(/ 10 5)

(+ 2.7 10)

(+ 21 35 12 7)

(* 25 4 12)

(+ (* 3 5) (- 10 6))

(+ (* 3 (+ (* 2 4) (+ 3 5))) (+ (- 10 7) 6))

;字下げする
(+ (* 3
      (+ (* 2 4)
         (+ 3 5)))
   (+ (- 10 7)
      6))

;1.1.2 名前と環境
;まさかのdefineが使用できない問題発生.下記のエラーが発生.
;scheme symbol's function definition is void
;原因としてはGaucheをemacsがきちんと認識できていなかった.
;init.elの(setq scheme-program-name "gosh")を
;(setq scheme-program-name "/usr/local/bin/gosh -i")へ。
;http://www.atmarkit.co.jp/ait/articles/0812/17/news149_3.htmに感謝.
(define size 2)

size ;->2

(* 5 size) ; ->10

;π
(define pi 3.14159)

;半径
(define radius 10)

;円の面積＝π×半径の2乗
(* pi (* radius radius)) ;->314.159

;円周＝π×直径
(define circumference (* 2 pi radius)) ; ->62.8318

;emacsの設定系
;http://qiita.com/da1/items/02f7d2f157c7145d58f2
;http://fkmn.exblog.jp/5485192/
;http://d.hatena.ne.jp/snow-bell/20081023/1224696331
;http://blog.livedoor.jp/incomplete_7/archives/51521573.html
