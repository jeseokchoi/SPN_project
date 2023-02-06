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

insert into product(product_code,product_name,product_price) values('m_top_1','�õ��� ������ Ƽ���� -���� ������',24900);
insert into product(product_code,product_name,product_price) values('m_top_2','������ ���̾�� ���� Ƽ����',12900);
insert into product(product_code,product_name,product_price) values('m_top_3','��긯 Ʈ���̴� �ĵ�',49900);
insert into product(product_code,product_name,product_price) values('m_top_4','ĳ��� ���͸� ������',32900);
insert into product(product_code,product_name,product_price) values('m_top_5','�𳪹� ������ ������',19900);
insert into product(product_code,product_name,product_price) values('m_top_6','���� ������ �޸� ������',27900);
insert into product(product_code,product_name,product_price) values('m_top_7','�õ��� ������ Ƽ���� -���� ������',24900);
insert into product(product_code,product_name,product_price) values('m_top_8','���� �� ���� Ƽ����',19900);
insert into product(product_code,product_name,product_price) values('m_top_9','���ϸ� ���� �ս�����',17900);
insert into product(product_code,product_name,product_price) values('m_top_10','���� ���� �� ������ Ƽ����',19900);
insert into product(product_code,product_name,product_price) values('m_top_11','����Ʈ ���� ����Ƽ',19900);
insert into product(product_code,product_name,product_price) values('m_top_12','�÷��� ���� ������',44900);
insert into product(product_code,product_name,product_price) values('m_top_13','����Ǯ ��Ŭ���� ���� ����Ƽ',12900);
insert into product(product_code,product_name,product_price) values('m_top_14','���Ĵٵ� �� ������',16900);
insert into product(product_code,product_name,product_price) values('m_top_15','������ ���� ���� Ƽ����',27900);

--����� ���̺�
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
