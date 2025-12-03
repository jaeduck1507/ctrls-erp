-- 제품 테이블
CREATE TABLE product( 
product_no INT AUTO_INCREMENT PRIMARY KEY, 
production_date DATE NOT NULL, -- 생산일
product_code INT NOT NULL -- 제품명 외래키
);

-- 제품명 테이블(제품에 대한 모든 정보)
CREATE TABLE product_name(
product_code INT AUTO_INCREMENT PRIMARY KEY,
product_color VARCHAR(10) NOT NULL, -- 제품 색깔(제품명에 들어가야할지?)
product_name VARCHAR(20) NOT NULL, -- 제품명
product_price INT NOT NULL, -- 제품 가격
product_cost INT NOT NULL, -- 제품 단가
product_category VARCHAR(20) NOT NULL
    CHECK (product_category IN ('상의', '하의', '악세사리', '신발')),
brand_code INT NOT NULL -- 브랜드 외래키
);

-- 품질검사 테이블
CREATE TABLE qc (
    qc_code INT AUTO_INCREMENT PRIMARY KEY,
    check_material VARCHAR(30) CHECK (check_material IN ('합격', '불합격')) DEFAULT NULL, -- 부자재 검사
    check_color VARCHAR(30) CHECK (check_color IN ('합격', '불합격')) DEFAULT NULL,       -- 색깔 검사
    check_damage VARCHAR(30) CHECK (check_damage IN ('합격', '불합격')) DEFAULT NULL,     -- 손상 검사
    qc_desc TEXT,              -- 평가 결과 특이사항
    qc_date DATE DEFAULT NULL, -- 품질 검사 날짜
    emp_no INT DEFAULT NULL,   -- 직원 외래키 (검사자)
    product_no INT NOT NULL,   -- 제품 외래키
    CONSTRAINT uq_qc_product UNIQUE (product_no)
);

-- 판매 테이블
CREATE TABLE sale(
sale_no INT AUTO_INCREMENT PRIMARY KEY,
sale_date DATE DEFAULT NULL, -- 판매일
product_no INT NOT NULL, -- 상품 외래키
sale_registered CHAR(1) DEFAULT 'N' -- 매출 등록 여부
);

-- 불량품 테이블
CREATE TABLE defective(
defective_no INT AUTO_INCREMENT PRIMARY KEY,
product_no INT NOT NULL, -- 상품 외래키
reason TEXT
);

-- 브랜드 테이블
CREATE TABLE brand (
	brand_code INT AUTO_INCREMENT PRIMARY KEY,
    brand_name VARCHAR (30),
    brand_phone VARCHAR (20) NOT NULL,
    brand_account VARCHAR (30) NOT NULL,
    brand_bank VARCHAR (30) NOT NULL
);