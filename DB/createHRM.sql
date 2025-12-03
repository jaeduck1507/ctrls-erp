-- user 아이디 패스워드 생성
CREATE TABLE user(
	username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(100) NOT NULL,
    role VARCHAR(100) NOT NULL,
    emp_no INT NOT NULL
);

-- 직원 정보 테이블 생성
CREATE TABLE employee_info (
    emp_no INT AUTO_INCREMENT PRIMARY KEY, -- 직원 고유 번호 (자동 증가, 기본 키)
    emp_in VARCHAR(14) UNIQUE NOT NULL CHECK (emp_in REGEXP '^[0-9]{6}-[1-4][0-9]{6}$'), -- 주민등록번호 (고유, 형식 확인, 필수)
    emp_name VARCHAR(50) NOT NULL, -- 직원 이름 (필수)
    job_no INT NOT NULL, -- 직급 번호 (외래 키, 필수)
    dept_no INT NOT NULL, -- 부서 번호 (외래 키, 필수)
    hire_date DATE NOT NULL, -- 입사일 (필수)
    quit_date DATE DEFAULT NULL, -- 퇴사일 (NULL이면 재직 중)
    salary INT NOT NULL, -- 기본 연봉 (0 이상, 필수)
    addr VARCHAR(200), -- 주소 (선택)
    phone VARCHAR(20), -- 연락처 (선택)
    email VARCHAR(100), -- 이메일 (형식 확인, 선택)
    url VARCHAR(200)
);
-- gender and age can be inferred by emp_in, which is 주민등록번호. 
-- The first 6 numbers is when they were born(YY/MM/DD) and if 
-- the 7th number that is next to '-' is 1 or 3, they are male, and if its 2 or 4, they are female.

-- 직급 테이블 생성
CREATE TABLE job_position (
    job_no INT AUTO_INCREMENT PRIMARY KEY, -- 직급 번호 (자동 증가, 기본 키)
    job_title VARCHAR(50) NOT NULL UNIQUE, -- 직급명 (고유, 필수)
    job_level INT NOT NULL, -- 직급 레벨 (낮을수록 상위, 필수)
    leave_count INT, -- 직급별 휴가 일수 (0 이상)
    description TEXT -- 직급 설명 (선택)
);

-- 부서 테이블 생성
CREATE TABLE department (
    dept_no INT AUTO_INCREMENT PRIMARY KEY, -- 부서 번호 (자동 증가, 기본 키)
    dept_name VARCHAR(50) NOT NULL UNIQUE, -- 부서 이름 (고유, 필수)
    location VARCHAR(100) -- 부서 위치 (선택)
);

-- 출퇴근/근태 관리 테이블 생성
CREATE TABLE attendance_log (
    att_id INT AUTO_INCREMENT PRIMARY KEY, -- 출퇴근 기록 번호 (자동 증가, 기본 키)
    emp_no INT NOT NULL, -- 직원 번호 (외래 키, 필수)
    work_date DATE NOT NULL DEFAULT (CURRENT_DATE), -- 근무 날짜 (필수)
    check_in TIME DEFAULT (CURRENT_TIMESTAMP), -- 출근 시간 (선택)
    check_out TIME, -- 퇴근 시간 (선택)
    status VARCHAR(10) CHECK (status IN ('휴가')) -- 근태 상태 휴가아니면 null로
);

-- 휴가 신청 테이블 생성
CREATE TABLE leave_request (
    leave_id INT AUTO_INCREMENT PRIMARY KEY, -- 휴가 신청 번호 (자동 증가, 기본 키)
    emp_no INT NOT NULL, -- 직원 번호 (외래 키, 필수)
    leave_type VARCHAR(10) NOT NULL CHECK (leave_type IN ('연차', '병가', '경조사', '기타')), -- 휴가 유형 (제한된 값, 필수)
    start_date DATE NOT NULL, -- 휴가 시작일 (필수)
    end_date DATE NOT NULL, -- 휴가 종료일 (시작일 이후, 필수)
    reason TEXT,
    status VARCHAR(10) DEFAULT '대기' CHECK (status IN ('대기', '승인', '반려')), -- 휴가 상태 (기본값: 대기)
    request_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- 신청 날짜 (기본값: 현재 시간)
);

-- 휴가 잔여 테이블 생성
CREATE TABLE leave_remain (
    lr_no INT AUTO_INCREMENT PRIMARY KEY, -- 휴가 잔여 번호 (자동 증가, 기본 키)
    lr_count INT NOT NULL, -- 잔여 휴가 일수 (0 이상, 필수)
    leave_year INT, -- 휴가 연도 (1900년 이후, 현재 연도 이하)
    emp_no INT NOT NULL -- 직원 번호 (외래 키, 필수)
);

-- 인사 평가 테이블 생성
CREATE TABLE performance_review (
    review_id INT AUTO_INCREMENT PRIMARY KEY, -- 평가 번호 (자동 증가, 기본 키)
    emp_no INT NOT NULL, -- 평가 대상 직원 번호 (외래 키, 필수)
    evaluator_emp_no INT NOT NULL, -- 평가자 직원 번호 (자기 자신 제외, 필수)
    review_date DATE NOT NULL DEFAULT (CURRENT_DATE), -- 평가 날짜 (필수)
    attitude_score INT CHECK (attitude_score BETWEEN 1 AND 5), -- 근무 태도 점수 (1~5)
    achieve_score INT CHECK (achieve_score BETWEEN 1 AND 5), -- 성과 점수 (1~5)
    comments TEXT -- 평가 코멘트 (선택)
);

-- 퇴사자 관리 테이블 생성
CREATE TABLE quitter (
    quit_no INT AUTO_INCREMENT PRIMARY KEY, -- 퇴사자 번호 (자동 증가, 기본 키)
    quit_pay INT, -- 퇴직금 (0 이상)
    quit_pay_date DATE, -- 퇴직금 지급 날짜 (선택)
    emp_no INT NOT NULL -- 직원 번호 (외래 키, 필수)
);

