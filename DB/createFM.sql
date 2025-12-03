-- 재무관리
-- 급여 관리
CREATE TABLE salary(
	salary_no INT AUTO_INCREMENT PRIMARY KEY, -- 급여 번호
    salary_date DATE, -- 지급일
    base_salary INT, -- 기본급
    bonus INT, -- 보너스
    deduction INT, -- 공제 금액
    tax INT, -- 세금
    
    emp_no INT NOT NULL -- 사원 번호 외래키
);

-- 예산 계획
CREATE TABLE budget(
	budget_no INT AUTO_INCREMENT PRIMARY KEY, -- 예산 번호
    period_type VARCHAR(2) CHECK (period_type IN ('Y', 'Q', 'M')), --  (연/분기/월: Y/Q/M)
    period_value VARCHAR(10), -- 적용 기간 값 (예 : 2025, 2025-Q1 등)
    annual_budget INT, -- 예산 금액
    plan TEXT, -- 계획 상세
    execution_date DATE, -- 예산 집행일
    dept_no INT NOT NULL -- 부서 번호 외래키
);

-- 수입/지출 관리
CREATE TABLE transaction(
	trans_no INT AUTO_INCREMENT PRIMARY KEY, -- 거래 번호
    trans_type VARCHAR(10) CHECK (trans_type IN ('수입', '지출')), -- 수입/지출
    trans_amount INT, -- 금액
    category VARCHAR(50), -- 분류
    trans_desc TEXT, -- 수입/지출 내역 상세
    trans_date DATE, -- 수입/지출 발생 일자
    dept_no INT NOT NULL -- 부서 번호 외래키 (통계 처리 하려면) 
);

-- 의류 ERP (매입 내역 관리용) -> 외부에서 구매한 내역
-- 상품/자재 , 매입일, 단가/수랑, 부가세, 공급업체, 부서
CREATE TABLE purchase(
	purchase_no INT AUTO_INCREMENT PRIMARY KEY, -- 매입 번호
    unit_price INT, -- 단가
    quantity INT, -- 수량
    var_amount INT, -- 부가세 총액
    total_amount INT, -- 총액 unit_price * quantity 
    purchase_date DATE, -- 매입일
    product_code INT NOT NULL, -- 상품 번호 외래키
    brand_code INT NOT NULL -- 거래처 번호 외래키
);

-- 매출 관리
CREATE TABLE sale_manage(
	sm_no INT AUTO_INCREMENT PRIMARY KEY, -- 매출 번호
    sale_date DATE, -- 매출 발생일자
    quantity INT, -- 수량
    var_amount INT, -- 부가세
    total_amount INT, -- 총액
    product_code INT NOT NULL -- 품목 번호 외래키
);

-- 수당 종류 테이블 생성
CREATE TABLE bonus (
    bonus_no INT AUTO_INCREMENT PRIMARY KEY, -- 수당 번호 (자동 증가, 기본 키)
    bonus_name VARCHAR(50), -- 수당 이름 (선택)
    bonus_desc TEXT -- 수당 설명 (선택)
);

-- 수당 지급 테이블 생성
CREATE TABLE bonus_payment (
    bonus_payment_no INT AUTO_INCREMENT PRIMARY KEY, -- 수당 지급 번호 (자동 증가, 기본 키)
    payment INT NOT NULL, -- 수당 금액 (필수)
    pay_date DATE NOT NULL, -- 지급 날짜 (필수)
    bonus_no INT NOT NULL, -- 수당 번호 (외래 키, 필수)
    emp_no INT NOT NULL -- 직원 번호 (외래 키, 필수)
);