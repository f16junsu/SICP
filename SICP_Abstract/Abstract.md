# **Structure and Interpretation of Computer Programs**

### 1. 프로시저를 써서 요약하는 방법
#### 1.1.5 substitution model로 프로시저를 실행하는 방법
* compound 프로시저를 인자에 적용시킨다는 것은 프로시저 formal parameter를 저마다 대응하는 인자 값으로 맞바꾼 다음 연산하는 것이다.
* normal-order evaluation : 끝까지 펼쳐서 더이상 펼칠 수 없는 primitive들만 있을 때 연산한다.
* applicative-order evaluation : 인자들을 먼자 계산하여 프로시저에 적용시켜 연산한다.
* sequence of expression? : scheme에서 squencing은 begin이라는 연산자를 사용한다. 변수 정의할 때 사용하는 define에는 begin이 내재되어 있기 때문에 begin이라는 키워드 없이도 여러 표현식을을 사용할 수 있다.(define 내에서 또 define을 한다던지 display나 newline을 호출하는 등)
* from practice 1.16, 반복 알고리즘을 설계할 때 변하지 않는 값(invariant quantity)를 설정하는 것이 도움이 된다.
### 2. 데이터를 요약해서 표현력을 끌어올리는 방법
#### 2.1.3 데이터란 무엇인가
* 데이터란, 형성자나 선택자, 이런 프로시저가 알맞은 데이터 표현을 만들어 내는지 따져볼 수 있는 조건까지 함께 정의해 놓은 것
#### 2.1 계층 구조 데이터와 닫힘 성질
* 닫힘 성질(closure) : 어떤 데이터 구조가 그 데이터 구조의 요소가 될 수 있는 것(엮은식이 다시 엮은 식의 원소가 되거나 쌍이 다시 쌍의 원소가 되는 등)
### 3. 모듈, 물체, 상태
### 4. 언어를 처리하는 기법
### 5. 레지스터 기계로 계산하기