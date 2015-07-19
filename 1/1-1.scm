
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

;1.1.3 組み合わせの評価
;組み合わせを評価する.
;1.組み合わせの部分式を評価する.
;2.最左部分式の値てある手続き(演算子)を、残りの部分式である引数(非演算子)に作用させる.
;評価の規則は、本質的に再帰的(recursive)である.
;再帰は階層的な木構造のオブジェクトを扱うのに強力な技法.

;1.1.4 合成手続き

;二乗する
(define (square x) (* x x))
(square 21) ;->441
(square (+ 2 5)) ;->49
(square (square 3)) ;->81

;引数として2つの数値をとり、それらの二乗の和を作る手続き
(define (sum-of-squares x y) (+ (* x x) (* y y)))
;と書いてみたが、上記のsquareがあるので下記がベスト.
(define (sum-of-squares x y) (+ (square x) (square y)))

(sum-of-squares 3 4) ;->25

;別の手続きを作る組み立て素材とすることもできる.
(define (f a) (sum-of-squares (+ a 1) (* a 2)))

(f 5);->136

;1.1.5 手続き作用の置換えモデル
;正規順序の評価
;完全に展開し、簡約する.
;作用的順序の評価
;引数を評価し、作用させる.

;1.1.6 条件式と述語
;場合分けの登場(case analysis)
(define (abs x)
  (cond ((> x 0) x)
        ((= x 0) 0)
        ((< x 0) (-x))))

(define (abs x)
  (cond ((< x 0) (-x))
        (else x)))

(define (abs x)
  (if (< x 0)
      (-x)
      x))

;問題1.1
10 ;->10
(+ 5 3 4) ;->12
(- 9 1) ;->8
(/ 6 2) ;->3
(+ (* 2 4) (- 4 6)) ;->6
(define a 3)
(define b (+ a 1))
(+ a b (* a b)) ;->19
(= a b) ;->#f
(if (and (> b a) (< b (* a b)))
 b
 a)
;->4
(cond ((= a 4) b)
      ((= b 4) (+ 6  7 a))
      (else 25))
;->16
(+ 2 (if (> b a) b a)) ;->6
(* (cond ((> a b) a)
         ((< a b) b)
         (else -1))
   (+ a 1))
;->16

;問題1.2
(/ (+ 5
      4
      (- 2
         (- 3
            (+ 6
               (/ 4
                  5)))))
   (* 3
      (- 6
         2)
      (- 2
         7)))
;->-37/150

;問題1.3
;三つの数を引数に取り、大きい数の二乗の和を返す手続き
(define (square-two-large-numbers x1 x2 x3) 
(cond ((and (> x1 x3) (> x2 x3)) (+ (* x1 x1) (* x2 x2)))
      ((and (> x1 x2) (> x3 x2)) (+ (* x1 x1) (* x3 x3)))
      ((and (> x3 x1) (> x2 x1)) (+ (* x2 x2) (* x3 x3)))
))

;問題1.4
(define (a-plus-abs-b a b)
        ((if (> b 0) + -) a b))
;->bを絶対値として和を計算する.

;問題1.5
;最初は以下のように勘違いしてしまった.
;作用的順序・・・0
;正規順序・・・評価できない
(define (p) (p))
(define (test x y )
        (if (= x 0)
            0
            y))
(test 0 (p))
;実際に動かしてみると、何も表示されない.
;http://d.hatena.ne.jp/knowledgetree/20100912/1284305197
;逆だった...
;p.8には「別の評価モデルでは、その値が必要になるまで、非演算子を評価しない.」とある.
;言葉の意味としては理解できたが、まだ完全に納得できていない...
