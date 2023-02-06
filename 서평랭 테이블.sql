drop sequence product_review_seq;
drop sequence review_reply_seq;
drop sequence product_seq;
drop sequence product_opt_seq;
drop sequence cart_seq;


drop sequence qna_seq;
drop sequence qna_reply_seq;
drop sequence notice_seq;

create sequence product_review_seq start with 1 MAXVALUE 999999 INCREMENT by 1 nocycle NOCACHE;
create sequence review_reply_seq start with 1 MAXVALUE 999999 INCREMENT by 1 nocycle NOCACHE;
create sequence product_seq start with 1 MAXVALUE 999999 INCREMENT by 1 nocycle NOCACHE;
create sequence product_opt_seq start with 1 MAXVALUE 999999 INCREMENT by 1 nocycle NOCACHE;
create sequence cart_seq start with 1 MAXVALUE 999999 INCREMENT by 1 nocycle NOCACHE;

create sequence qna_seq start with 1 MAXVALUE 999999 INCREMENT by 1 nocycle NOCACHE;
create sequence qna_reply_seq start with 1 MAXVALUE 999999 INCREMENT by 1 nocycle NOCACHE;
create sequence notice_seq start with 1 MAXVALUE 999999 INCREMENT by 1 nocycle NOCACHE;

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

select * from product;
commit;

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

--썸네일 테이블
create table product_t_img (
    product_t_img           varchar2(100)            not null,
    product_idx             number                   not null,   
    
    constraint product_t_img_product
    foreign key(product_idx)
    references product(product_idx)
    on delete set null
);

create table product_t_img (
    product_t_img           varchar2(100)            not null,
    product_idx             number                   not null,   
    
    constraint product_t_img_product
    foreign key(product_idx)
    references product(product_idx)
    on delete set null
);
