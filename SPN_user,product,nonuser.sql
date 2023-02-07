--table 삭제
drop table userOrder_refund;
drop table userOrder_exchange;
drop table userOrder_detail;
drop table user_order;
drop table deliver_address;
drop table review_reply;
drop table product_review;
drop table userTable;
drop table cart;
drop table product_opt;
drop table product_d_img;
drop table product_t_img;
drop table product;

-- product/qna 삭제 --
drop sequence product_review_seq;
drop sequence review_reply_seq;
drop sequence product_seq;
drop sequence cart_seq;
drop sequence product_opt_seq;

drop sequence qna_seq;
drop sequence qna_reply_seq;
drop sequence notice_seq;

-- user/nonuser 삭제 --
drop sequence nonuserOrder_detail_seq;
drop sequence nonuserOrder_refund_seq;
drop sequence nonuserOrder_exchange_seq;
drop sequence nonuser_order_seq;

drop sequence userOrder_detail_seq;
drop sequence userOrder_refund_seq;
drop sequence user_idx_seq;
drop sequence user_order_seq;
drop sequence userOrder_exchange_idx;

-- product/qna 생성 --
create sequence product_review_seq start with 1 MAXVALUE 999999 INCREMENT by 1 nocycle NOCACHE;
create sequence review_reply_seq start with 1 MAXVALUE 999999 INCREMENT by 1 nocycle NOCACHE;
create sequence product_seq start with 1 MAXVALUE 999999 INCREMENT by 1 nocycle NOCACHE;
create sequence product_opt_seq start with 1 MAXVALUE 999999 INCREMENT by 1 nocycle NOCACHE;
create sequence cart_seq start with 1 MAXVALUE 999999 INCREMENT by 1 nocycle NOCACHE;

create sequence qna_seq start with 1 MAXVALUE 999999 INCREMENT by 1 nocycle NOCACHE;
create sequence qna_reply_seq start with 1 MAXVALUE 999999 INCREMENT by 1 nocycle NOCACHE;
create sequence notice_seq start with 1 MAXVALUE 999999 INCREMENT by 1 nocycle NOCACHE;
------------------------------------------------------------------------

-- user/nonuser 생성 --
create sequence nonuserOrder_detail_seq start with 1 MAXVALUE 999999 INCREMENT by 1 nocycle NOCACHE;
create sequence nonuserOrder_refund_seq start with 1 MAXVALUE 999999 INCREMENT by 1 nocycle NOCACHE;
create sequence nonuserOrder_exchange_seq start with 1 MAXVALUE 999999 INCREMENT by 1 nocycle NOCACHE;
create sequence nonuser_order_seq start with 1 MAXVALUE 999999 INCREMENT by 1 nocycle NOCACHE;

create sequence userOrder_detail_seq start with 1 MAXVALUE 999999 INCREMENT by 1 nocycle NOCACHE;
create sequence userOrder_refund_seq start with 1 MAXVALUE 999999 INCREMENT by 1 nocycle NOCACHE;
create sequence user_idx_seq start with 1 MAXVALUE 999999 INCREMENT by 1 nocycle NOCACHE;
create sequence user_order_seq start with 1 MAXVALUE 999999 INCREMENT by 1 nocycle NOCACHE;
create sequence userOrder_exchange_idx start with 1 MAXVALUE 999999 INCREMENT by 1 nocycle NOCACHE;
---------------------------------------------------------------------------------------------------------------

-- user테이블 생성 --

CREATE TABLE userTable (
	user_id	varchar2(30)	NOT NULL primary key,
	user_idx	number	DEFAULT user_idx_seq.nextval	NOT NULL,
	user_pwd	varchar2(255)		NOT NULL,
	user_name	varchar2(20)		NOT NULL,
	user_phone	varchar2(20)		NOT NULL,
	user_email	varchar2(50)		NOT NULL,
	email_check	varchar2(2)		NOT NULL,
	user_role	number		NOT NULL,
	user_grade	varchar2(10)		NOT NULL,
	user_insertDate	date	DEFAULT sysdate	NOT NULL
);

-- userOrder table 생성
CREATE TABLE user_order (
	user_order_idx	number	DEFAULT user_order_seq.nextval primary key,
	user_id	varchar2(30)	NOT NULL,
	order_date	date	DEFAULT sysdate 	NOT NULL,
	address1	varchar2(20)	NOT NULL,
	address2	varchar2(50)	NOT NULL,
	address3	varchar2(50)	NOT NULL,
	order_total_price	number	NOT NULL,
	receiver_name	varchar2(20)	NOT NULL,
	receiver_phone	varchar2(20)	NOT NULL,
	order_detail_status	varchar(20)	NOT NULL,
    
    constraint user_order_user
    foreign key(user_id)
    references userTable(user_id)
);
-- deliverAddress table 생성

CREATE TABLE deliver_address (
	user_id	varchar2(30)	NOT NULL,
	user_address1	varchar2(20)	NOT NULL,
	user_address2	varchar2(50)	NOT NULL,
	user_address3	varchar2(50)	NOT NULL,
    
    constraint deliver_address_userTable
    FOREIGN key(user_id)
    REFERENCES userTable(user_id)
);
--product table 생성
create table product (
    product_idx             number              default product_seq.nextval  primary key,
    product_code            varchar2(20)        not null,
    product_name            varchar2(50)        not null,
    product_price           number              not null,
    product_desc            varchar2(3000)      ,
    product_date            date                default sysdate not null,
    product_hits            number              default 0 not null,
    delete_check            varchar2(2)         default 'n' not null,
    show_check              varchar2(10)        default 'show' not null   
);

-- product 더미입력
insert into product(product_code,product_name,product_price) values('m_top_1','올데이 베이직 티셔츠 -반팔 오버핏',24900);
insert into product(product_code,product_name,product_price) values('m_top_2','베이직 레이어드 반팔 티셔츠',12900);
insert into product(product_code,product_name,product_price) values('m_top_3','페브릭 트레이닝 후드',49900);
insert into product(product_code,product_name,product_price) values('m_top_4','캐쥬얼 레터링 맨투맨',32900);
insert into product(product_code,product_name,product_price) values('m_top_5','모나미 베이직 맨투맨',19900);
insert into product(product_code,product_name,product_price) values('m_top_6','뮤즈 베이직 쭈리 맨투맨',27900);
insert into product(product_code,product_name,product_price) values('m_top_7','올데이 베이직 티셔츠 -긴팔 오버핏',24900);
insert into product(product_code,product_name,product_price) values('m_top_8','라운드 넥 실켓 티셔츠',19900);
insert into product(product_code,product_name,product_price) values('m_top_9','데일리 무지 롱슬리브',17900);
insert into product(product_code,product_name,product_price) values('m_top_10','유넥 네츄럴 롱 슬리브 티셔츠',19900);
insert into product(product_code,product_name,product_price) values('m_top_11','소프트 라운드 긴팔티',19900);
insert into product(product_code,product_name,product_price) values('m_top_12','플래닛 발포 맨투맨',44900);
insert into product(product_code,product_name,product_price) values('m_top_13','리버풀 링클프리 라운드 긴팔티',12900);
insert into product(product_code,product_name,product_price) values('m_top_14','스탠다드 롱 슬리브',16900);
insert into product(product_code,product_name,product_price) values('m_top_15','베이직 무지 폴라 티셔츠',27900);

--썸네일 테이블 생성
create table product_t_img (
    product_t_img           varchar2(100)            not null,
    product_idx             number                   not null,   
    
    constraint product_t_img_product
    foreign key(product_idx)
    references product(product_idx)
);

--상세이미지 테이블 생성
create table product_d_img (
    product_d_img           varchar2(100)            not null,
    product_idx             number                   not null,   
    
    constraint product_d_img_product
    foreign key(product_idx)
    references product(product_idx)
);

--제품 옵션 테이블 생성
create table product_opt (
    product_opt_idx           number            default product_opt_seq.nextval  primary key,
    product_idx             number              not null,
    product_size            varchar2(50)        not null,
    product_color           varchar2(100)       not null,
    product_stock           number              default 0 not null,
    
    constraint product_opt_product
    foreign key(product_idx)
    references product(product_idx)
);

--장바구니 테이블 생성
create table cart (
    cart_idx                number            default cart_seq.nextval  primary key,
    product_opt_idx         number            not null,
    cart_value              varchar2(30)      not null,
    product_count           number            default 0 not null, --제품수량인데 0이면 안되나?
    
    constraint cart_product_opt
    foreign key(product_opt_idx)
    references product_opt(product_opt_idx)
);

--제품리뷰 테이블 생성
create table product_review (
    product_review_idx         number           default product_review_seq.nextval  primary key,
    product_opt_idx            number           not null,
    user_id                    varchar2(30)     not null,
    rate                       number           not null,
    content                    varchar2(3000)   not null,
    writing_date               date             default sysdate not null,
    delete_check               varchar2(2)      default 'n' not null,
    
    constraint product_review_product_opt
    foreign key(product_opt_idx)
    references product_opt(product_opt_idx),
    
    constraint product_review_userTable
    foreign key(user_id)
    references userTable(user_id)
);

--리뷰에 답글 테이블 생성
create table review_reply (
    review_reply_idx           number           default product_review_seq.nextval  primary key,
    product_review_idx         number           not null,
    content                    varchar2(30)     not null,
    writing_date               date             default sysdate not null,
    
    constraint review_reply_product_review
    foreign key(product_review_idx)
    references product_review(product_review_idx)
);
--userOrder_detail 테이블 생성
CREATE TABLE userOrder_detail (
	userOrder_detail_idx	number DEFAULT userOrder_detail_seq.nextval primary key,
	product_opt_idx	number	not null,
	user_order_idx	number	not null,
	product_count	number	NOT NULL,
	product_price	number	NOT NULL,
    
    constraint userOrder_detail_opt_idx
    foreign key (product_opt_idx)
    REFERENCES product_opt(product_opt_idx),
    
    constraint userOrder_detail_user_order_idx
    foreign key (user_order_idx)
    REFERENCES user_order(user_order_idx)
);

--userOrder Refund 테이블 생성

CREATE TABLE userOrder_refund (
	userOrder_refund_idx	number	DEFAULT userOrder_refund_seq.nextval primary key,
	userOrder_detail_idx	number	NOT NULL,
	refund_reason	varchar2(3000)	NOT NULL,
	reason_img	varchar2(300)	NOT NULL,
	userOrder_refund_status	varchar(50)	NOT NULL,
    
    constraint userOrder_refund_userOrder_detail
    FOREIGN key(userOrder_detail_idx)
    REFERENCES userOrder_detail(userOrder_detail_idx)
  
);

CREATE TABLE userOrder_exchange (
	userOrder_exchange_idx	number	DEFAULT userOrder_exchange_idx.nextval,
	userOrder_detail_idx	number	NOT NULL,
	exchange_reason	varchar2(3000)	NOT NULL,
	reason_img	varchar2(300)	NOT NULL,
	userOrder_exchange_status	varchar(50)	NOT NULL,
    
    constraint userOrder_exchange_userOrder_detail
    foreign key(userOrder_detail_idx)
    references userOrder_detail(userOrder_detail_idx)
);
--nonuser Order
CREATE TABLE nonuser_order (
	nonuser_order_idx	number	DEFAULT nonuser_order_seq.nextval primary key,
	order_date	date	DEFAULT sysdate	NOT NULL,
	address1	varchar2(20)		NOT NULL,
	address2	varchar2(50)		NOT NULL,
	address3	varchar2(50)		NOT NULL,
	receiver_name	varchar2(20)		NOT NULL,
	receiver_phone	varchar2(20)		NOT NULL,
	nonuser_order_status	varchar2(20)		NOT NULL,
    nonuser_pwd             varchar2(20)        NOT NULL
);
--nonuserOrder detail
CREATE TABLE nonuserOrder_detail (
	nonuserOrder_detail_idx	number	DEFAULT nonuserOrder_detail_seq.nextval primary key,
	product_opt_idx         	number	NOT NULL,
	nonuser_order_idx	    number  NOT NULL,
	
    product_count	number		NOT NULL,
	product_price	number		NOT NULL,
    
    constraint fk_nonuser_order  --  제약조건의 이름
    foreign key(nonuser_order_idx)           --  외래키가될 컬럼
    REFERENCES nonuser_order(nonuser_order_idx),    --  외래키가 참조하는 테이블 (컬럼)
           
    constraint fk_product_opt  --  제약조건의 이름
    foreign key(product_opt_idx)           --  외래키가될 컬럼
    REFERENCES product_opt(product_opt_idx)    --  외래키가 참조하는 테이블 (컬럼)
       --  부모키가 삭제될 경우 처리  // 상품이 제거되면 매출건도 사라진다.
);
--nonuserOrder_refund
CREATE TABLE nonuserOrder_refund (
	nonuserOrder_refund_idx	number	DEFAULT nonuserOrder_refund_seq.nextval primary key,
	nonuserOrder_detail_idx	number NOT NULL,
	refund_reason	varchar2(3000)		NOT NULL,
	reason_img	varchar2(300)		NOT NULL,
	user_email	varchar(50)		NOT NULL,

    constraint fk_nonuserOrder_detail  --  제약조건의 이름
    foreign key(nonuserOrder_detail_idx)           --  외래키가될 컬럼
    REFERENCES nonuserOrder_detail(nonuserOrder_detail_idx)    --  외래키가 참조하는 테이블 (컬럼)
);
--nonuserOrder_exchange
CREATE TABLE nonuserOrder_exchange (
	nonuserOrder_exchange_idx	number	DEFAULT nonuserOrder_exchange_seq.nextval primary key,
	nonuserOrder_detail_idx	number	DEFAULT nonuserOrder_detail_seq.nextval NOT NULL,
	exchange_reason	varchar2(3000)		NOT NULL,
	reason_img	varchar2(300)		NOT NULL,
	nonuserOrder_exchange_status	varchar(50)		NOT NULL,
    
     constraint fk_nonuserOrder_detail2  --  제약조건의 이름
    foreign key(nonuserOrder_detail_idx)           --  외래키가될 컬럼
    REFERENCES nonuserOrder_detail(nonuserOrder_detail_idx)    --  외래키가 참조하는 테이블 (컬럼)

);





