-- --------------------------------------------------------
-- 호스트:                          127.0.0.1
-- 서버 버전:                        10.6.21-MariaDB-ubu2004 - mariadb.org binary distribution
-- 서버 OS:                        debian-linux-gnu
-- HeidiSQL 버전:                  11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- HelloCharger 데이터베이스 구조 내보내기
CREATE DATABASE IF NOT EXISTS `HelloCharger` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `HelloCharger`;

-- 프로시저 HelloCharger.LST_ENVMemberCard_LST_EVCStationInfo 구조 내보내기
DELIMITER //
CREATE PROCEDURE `LST_ENVMemberCard_LST_EVCStationInfo`(
	IN `icardNo` VARCHAR(50),
	IN `iurlStatId` VARCHAR(50)
)
    COMMENT 'StationInfo에 castpro에 적합한 StatId가 있는 경우 테이블 1,3번 조회 이외에는 테이블 1번만 조회'
BEGIN
	DECLARE memberId VARCHAR(50);	

	IF iurlStatId IS NULL THEN
		SELECT bid,inValid,upddate FROM tENVMemberCard WHERE cardNo = icardNo AND (bid = 'ME' OR bid = 'CP' OR bid = 'HE' OR bid = 'ET' OR bid = 'HR' OR bid = 'CS' OR bid = 'VT' OR bid = 'TV' OR bid = 'SD') 
		UNION ALL
		SELECT bid,inValid,upddate FROM tENVMemberCard3 WHERE cardNo = icardNo AND (bid = 'ME' OR bid = 'CP' OR bid = 'HE' OR bid = 'ET' OR bid = 'HR' OR bid = 'CS' OR bid = 'VT' OR bid = 'TV' OR bid = 'SD') ORDER BY upddate desc LIMIT 1;
	ELSE
		SELECT member_id INTO memberId FROM tEVCStationInfo WHERE statId = iurlStatId LIMIT 1;
		
		CASE memberId
			WHEN 'castpro' THEN
				SELECT bid,inValid,upddate FROM tENVMemberCard WHERE cardNo = icardNo AND (bid = 'ME' OR bid = 'CP' OR bid = 'HE' OR bid = 'SD')
				UNION ALL
				SELECT bid,inValid,upddate FROM tENVMemberCard3 WHERE cardNo = icardNo AND (bid = 'ME' OR bid = 'CP' OR bid = 'HE' OR bid = 'SD') ORDER BY upddate desc LIMIT 1;
			WHEN 'ECT' THEN		
				SELECT bid,inValid,upddate FROM tENVMemberCard WHERE cardNo = icardNo AND (bid = 'ME' OR bid = 'ET')
				UNION ALL
				SELECT bid,inValid,upddate FROM tENVMemberCard3 WHERE cardNo = icardNo AND (bid = 'ME' OR bid = 'ET') ORDER BY upddate desc LIMIT 1;
			WHEN 'evrental' THEN
				SELECT bid,inValid,upddate FROM tENVMemberCard WHERE cardNo = icardNo AND (bid = 'ME' OR bid = 'HR')
				UNION ALL
				SELECT bid,inValid,upddate FROM tENVMemberCard3 WHERE cardNo = icardNo AND (bid = 'ME' OR bid = 'HR') ORDER BY upddate desc LIMIT 1;
			WHEN 'sgit' THEN
				SELECT bid,inValid,upddate FROM tENVMemberCard WHERE cardNo = icardNo AND (bid = 'ME' OR bid = 'CS')
				UNION ALL
				SELECT bid,inValid,upddate FROM tENVMemberCard3 WHERE cardNo = icardNo AND (bid = 'ME' OR bid = 'CS') ORDER BY upddate desc LIMIT 1;
			WHEN 'volta' THEN
				SELECT bid,inValid,upddate FROM tENVMemberCard WHERE cardNo = icardNo AND (bid = 'ME' OR bid = 'VT' OR bid = 'SD' OR icardNo = '9001021702170217')
				UNION ALL
				SELECT bid,inValid,upddate FROM tENVMemberCard3 WHERE cardNo = icardNo AND (bid = 'ME' OR bid = 'VT' OR bid = 'SD' OR icardNo = '9001021702170217') ORDER BY upddate desc LIMIT 1;
			WHEN 'EVC1' THEN
				SELECT bid,inValid,upddate FROM tENVMemberCard WHERE cardNo = icardNo AND (bid = 'ME' OR bid = 'TV')
				UNION ALL
				SELECT bid,inValid,upddate FROM tENVMemberCard3 WHERE cardNo = icardNo AND (bid = 'ME' OR bid = 'TV') ORDER BY upddate desc LIMIT 1;
			WHEN 'bossi' THEN
				SELECT bid,inValid,upddate FROM tENVMemberCard WHERE cardNo = icardNo AND (bid = 'ME' OR bid = 'BS')
				UNION ALL
				SELECT bid,inValid,upddate FROM tENVMemberCard3 WHERE cardNo = icardNo AND (bid = 'ME' OR bid = 'BS') ORDER BY upddate desc LIMIT 1;
			WHEN 'TEST' THEN
				SELECT bid,inValid,upddate FROM tENVMemberCard WHERE cardNo = icardNo AND (bid = 'ME' OR bid = 'CP')
				UNION ALL
				SELECT bid,inValid,upddate FROM tENVMemberCard3 WHERE cardNo = icardNo AND (bid = 'ME' OR bid = 'CP') ORDER BY upddate desc LIMIT 1;
			ELSE
				SELECT bid,inValid,upddate FROM tENVMemberCard WHERE cardNo = icardNo AND (bid = 'CP') 
				UNION ALL
				SELECT bid,inValid,upddate FROM tENVMemberCard3 WHERE cardNo = icardNo AND (bid = 'CP') ORDER BY upddate desc LIMIT 1;
		END CASE;
			
	END IF;
END//
DELIMITER ;

-- 테이블 HelloCharger.tAdminUsers 구조 내보내기
CREATE TABLE IF NOT EXISTS `tAdminUsers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `admin_id` varchar(10) NOT NULL,
  `admin_name` varchar(20) DEFAULT NULL,
  `admin_password` varchar(32) DEFAULT NULL,
  `status` tinyint(1) DEFAULT 1,
  `bid` varchar(2) DEFAULT '' COMMENT '환경부 BID',
  `bkey` varchar(16) DEFAULT '' COMMENT '환경부 BKEY',
  `updateTime` timestamp NOT NULL DEFAULT (current_timestamp() + interval 9 hour),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 HelloCharger.tAdminUsers:~0 rows (대략적) 내보내기
DELETE FROM `tAdminUsers`;
/*!40000 ALTER TABLE `tAdminUsers` DISABLE KEYS */;
INSERT INTO `tAdminUsers` (`id`, `admin_id`, `admin_name`, `admin_password`, `status`, `bid`, `bkey`, `updateTime`) VALUES
	(4, 'admin', '관리자', 'aac73f1ea1d9ca40b720bc53691287a0', 1, '', '', '2021-03-26 17:02:23');
/*!40000 ALTER TABLE `tAdminUsers` ENABLE KEYS */;

-- 테이블 HelloCharger.tASChargerInfo 구조 내보내기
CREATE TABLE IF NOT EXISTS `tASChargerInfo` (
  `statId` varchar(8) NOT NULL,
  `chargerId` varchar(2) NOT NULL,
  `firstchargetime` datetime NOT NULL,
  `firstpaymenttime` timestamp NULL DEFAULT NULL,
  `lcd` timestamp NULL DEFAULT NULL,
  `relayboard` timestamp NULL DEFAULT NULL,
  `icreader` timestamp NULL DEFAULT NULL,
  `androidboard` timestamp NULL DEFAULT NULL,
  `rcd` timestamp NULL DEFAULT NULL,
  `j1772cable` timestamp NULL DEFAULT NULL,
  `controlboard` timestamp NULL DEFAULT NULL,
  `rfidreader` timestamp NULL DEFAULT NULL,
  `frontcase` timestamp NULL DEFAULT NULL,
  `bottomcase` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`statId`,`chargerId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='충전기 AS 관련 정보';

-- 테이블 데이터 HelloCharger.tASChargerInfo:~0 rows (대략적) 내보내기
DELETE FROM `tASChargerInfo`;
/*!40000 ALTER TABLE `tASChargerInfo` DISABLE KEYS */;
INSERT INTO `tASChargerInfo` (`statId`, `chargerId`, `firstchargetime`, `firstpaymenttime`, `lcd`, `relayboard`, `icreader`, `androidboard`, `rcd`, `j1772cable`, `controlboard`, `rfidreader`, `frontcase`, `bottomcase`) VALUES
	('111111', '01', '2025-05-07 12:14:12', '2025-05-07 12:14:12', '2027-05-07 12:14:12', '2027-05-07 12:14:12', '2027-05-07 12:14:12', '2027-05-07 12:14:12', '2027-05-07 12:14:12', '2027-05-07 12:14:12', '2027-05-07 12:14:12', '2027-05-07 12:14:12', '2027-05-07 12:14:12', '2027-05-07 12:14:12');
/*!40000 ALTER TABLE `tASChargerInfo` ENABLE KEYS */;

-- 테이블 HelloCharger.tChargerModel 구조 내보내기
CREATE TABLE IF NOT EXISTS `tChargerModel` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `chargerModel` varchar(20) NOT NULL COMMENT '충전기모델',
  `memo` varchar(100) NOT NULL DEFAULT '' COMMENT '부연설명',
  `updateTime` timestamp NULL DEFAULT (current_timestamp() + interval 9 hour),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 HelloCharger.tChargerModel:~15 rows (대략적) 내보내기
DELETE FROM `tChargerModel`;
/*!40000 ALTER TABLE `tChargerModel` DISABLE KEYS */;
INSERT INTO `tChargerModel` (`id`, `chargerModel`, `memo`, `updateTime`) VALUES
	(24, 'CSC-14000B7(2CH)', '', '2022-11-14 15:17:13'),
	(25, 'CSC-14000B7S(2CH)', '', '2022-11-14 15:16:00'),
	(26, 'CSC-7000A7(1CH)', '', '2022-11-14 15:18:53'),
	(27, 'CSC-7000A7S(1CH)', '', '2022-11-14 15:19:10'),
	(28, 'AE50K-C1XS-MO-1C', '50kW 급속충전', '2022-12-20 17:50:17'),
	(29, 'CSC-11A7(1CH)', '11kw 1채널', '2023-09-11 13:59:21'),
	(30, 'CSC-22B7(2CH)', '11kw 2채널', '2023-09-11 13:59:37'),
	(31, 'CSC-07A7-1', '', '2025-02-18 14:55:58'),
	(32, 'CSC-11A7-1', '', '2025-02-18 14:56:05'),
	(33, 'CSC-14B7', '', '2025-02-18 14:56:12'),
	(34, 'CSC-22B7-1', '', '2025-02-18 14:56:17'),
	(35, 'CSC-07A7-2 (PLC모뎀)', '', '2025-02-18 14:56:27'),
	(36, 'CSC-11A7-2 (PLC모뎀)', '', '2025-02-18 14:56:38'),
	(37, 'CSC-14B7-2 (PLC모뎀)', '', '2025-02-18 14:56:44'),
	(38, 'CSC-22B7-2 (PLC모뎀)', '', '2025-02-18 14:56:49');
/*!40000 ALTER TABLE `tChargerModel` ENABLE KEYS */;

-- 테이블 HelloCharger.tEmergencyContacts 구조 내보내기
CREATE TABLE IF NOT EXISTS `tEmergencyContacts` (
  `statId` varchar(8) NOT NULL,
  `chargerId` varchar(2) DEFAULT NULL,
  `telno` varchar(20) NOT NULL,
  `updatetime` datetime NOT NULL DEFAULT (current_timestamp() + interval 9 hour),
  PRIMARY KEY (`statId`,`telno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 HelloCharger.tEmergencyContacts:~0 rows (대략적) 내보내기
DELETE FROM `tEmergencyContacts`;
/*!40000 ALTER TABLE `tEmergencyContacts` DISABLE KEYS */;
/*!40000 ALTER TABLE `tEmergencyContacts` ENABLE KEYS */;

-- 테이블 HelloCharger.tEmergencyEvents 구조 내보내기
CREATE TABLE IF NOT EXISTS `tEmergencyEvents` (
  `statId` varchar(8) NOT NULL,
  `chargerId` varchar(2) DEFAULT NULL,
  `eventcode` tinyint(2) NOT NULL COMMENT '1: 불꽃감지',
  `Message` varchar(500) DEFAULT NULL,
  `invalid` tinyint(4) NOT NULL DEFAULT 0 COMMENT '0: 이벤트 발생, 1: 종료',
  `eventTime` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`statId`,`eventTime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 HelloCharger.tEmergencyEvents:~0 rows (대략적) 내보내기
DELETE FROM `tEmergencyEvents`;
/*!40000 ALTER TABLE `tEmergencyEvents` DISABLE KEYS */;
/*!40000 ALTER TABLE `tEmergencyEvents` ENABLE KEYS */;

-- 테이블 HelloCharger.tENVCommonCode 구조 내보내기
CREATE TABLE IF NOT EXISTS `tENVCommonCode` (
  `codeType` varchar(20) DEFAULT '' COMMENT '코드 구분자',
  `codeId` varchar(50) DEFAULT '' COMMENT '코드 ID',
  `codeName` varchar(100) DEFAULT '' COMMENT '코드 명',
  `codeNote` varchar(400) DEFAULT '' COMMENT '코드 노트',
  `updateTime` timestamp NULL DEFAULT (current_timestamp() + interval 9 hour),
  UNIQUE KEY `uENVCommonCode_idx1` (`codeType`,`codeId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 HelloCharger.tENVCommonCode:~0 rows (대략적) 내보내기
DELETE FROM `tENVCommonCode`;
/*!40000 ALTER TABLE `tENVCommonCode` DISABLE KEYS */;
/*!40000 ALTER TABLE `tENVCommonCode` ENABLE KEYS */;

-- 테이블 HelloCharger.tENVMemberCard 구조 내보내기
CREATE TABLE IF NOT EXISTS `tENVMemberCard` (
  `bid` varchar(2) NOT NULL DEFAULT '' COMMENT '기관ID',
  `cardNo` varchar(20) NOT NULL DEFAULT '' COMMENT '회원카드번호',
  `inValid` varchar(1) DEFAULT 'N' COMMENT 'N:사용가능, Y:사용정지',
  `regdate` varchar(14) DEFAULT '' COMMENT '회원카드 등록 일시, YYYYMMDDHHMMSS',
  `upddate` varchar(14) DEFAULT '' COMMENT '회원카드 갱신 일시, YYYYMMDDHHMMSS',
  `cardBalance` int(11) NOT NULL DEFAULT 0 COMMENT '-1:무제한, 0이상:잔액(원)',
  `updateTime` timestamp NOT NULL DEFAULT (current_timestamp() + interval 9 hour),
  PRIMARY KEY (`bid`,`cardNo`),
  KEY `idx_width_inValid` (`bid`,`cardNo`,`inValid`,`upddate`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 HelloCharger.tENVMemberCard:~0 rows (대략적) 내보내기
DELETE FROM `tENVMemberCard`;
/*!40000 ALTER TABLE `tENVMemberCard` DISABLE KEYS */;
INSERT INTO `tENVMemberCard` (`bid`, `cardNo`, `inValid`, `regdate`, `upddate`, `cardBalance`, `updateTime`) VALUES
	('LO', '4', 'N', '', '', 0, '2025-04-29 11:53:38');
/*!40000 ALTER TABLE `tENVMemberCard` ENABLE KEYS */;

-- 테이블 HelloCharger.tENVMemberCard3 구조 내보내기
CREATE TABLE IF NOT EXISTS `tENVMemberCard3` (
  `bid` varchar(2) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '' COMMENT '기관ID',
  `cardNo` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '' COMMENT '회원카드번호',
  `inValid` varchar(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT 'N' COMMENT 'N:사용가능, Y:사용정지',
  `regdate` varchar(14) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT '' COMMENT '회원카드 등록 일시, YYYYMMDDHHMMSS',
  `upddate` varchar(14) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT '' COMMENT '회원카드 갱신 일시, YYYYMMDDHHMMSS',
  `updateTime` timestamp NULL DEFAULT (current_timestamp() + interval 9 hour),
  PRIMARY KEY (`bid`,`cardNo`),
  KEY `idx_width_inValid` (`bid`,`cardNo`,`inValid`,`upddate`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 HelloCharger.tENVMemberCard3:~0 rows (대략적) 내보내기
DELETE FROM `tENVMemberCard3`;
/*!40000 ALTER TABLE `tENVMemberCard3` DISABLE KEYS */;
/*!40000 ALTER TABLE `tENVMemberCard3` ENABLE KEYS */;

-- 테이블 HelloCharger.tMonthlyChargeSettings 구조 내보내기
CREATE TABLE IF NOT EXISTS `tMonthlyChargeSettings` (
  `cardNo` varchar(16) NOT NULL COMMENT '회원카드번호',
  `amount` int(11) NOT NULL DEFAULT 0 COMMENT '월별 충전금액 (덮어쓰기)',
  `chargeDay` tinyint(2) NOT NULL DEFAULT 1 COMMENT '매월 충전일 (1-31)',
  `chargeHour` tinyint(2) NOT NULL DEFAULT 0 COMMENT '충전 시각 (0-23, KST)',
  `chargeMinute` tinyint(2) NOT NULL DEFAULT 0 COMMENT '충전 분 (0-59, KST)',
  `enabled` varchar(1) NOT NULL DEFAULT 'Y' COMMENT 'Y:활성, N:비활성',
  `updateTime` timestamp DEFAULT current_timestamp ON UPDATE current_timestamp,
  PRIMARY KEY (`cardNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 HelloCharger.tMonthlyChargeHistory 구조 내보내기
CREATE TABLE IF NOT EXISTS `tMonthlyChargeHistory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cardNo` varchar(16) NOT NULL COMMENT '회원카드번호',
  `chargeDateTime` datetime NOT NULL COMMENT '충전 실행 일시 (KST)',
  `amount` int(11) NOT NULL COMMENT '충전 금액 (덮어쓴 값)',
  `prevBalance` int(11) DEFAULT NULL COMMENT '이전 잔액',
  PRIMARY KEY (`id`),
  KEY `idx_cardNo_chargeDateTime` (`cardNo`,`chargeDateTime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 HelloCharger.tENVv2doRegiChargeHistory 구조 내보내기
CREATE TABLE IF NOT EXISTS `tENVv2doRegiChargeHistory` (
  `idx` int(11) NOT NULL AUTO_INCREMENT,
  `flag` tinyint(1) NOT NULL DEFAULT 0 COMMENT '해결여부 0: 대기, 1: 전송완료',
  `no` varchar(50) DEFAULT NULL,
  `sid` varchar(50) DEFAULT NULL,
  `cid` varchar(50) DEFAULT NULL,
  `tbid` varchar(50) DEFAULT NULL,
  `tsdt` varchar(50) DEFAULT NULL,
  `tedt` varchar(50) DEFAULT NULL,
  `btid` varchar(50) DEFAULT NULL,
  `pow` varchar(50) DEFAULT NULL,
  `mon` varchar(50) DEFAULT NULL,
  `bprice` varchar(50) DEFAULT NULL,
  `tbprice` varchar(50) DEFAULT NULL,
  `bmon` varchar(50) DEFAULT NULL,
  `rcvdate` varchar(50) DEFAULT NULL,
  `error_log` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`idx`),
  KEY `flag` (`flag`)
) ENGINE=InnoDB AUTO_INCREMENT=1196 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='doRegiCharge에서 에러가 났을때 저장하는 에러로그 테이블 입니다.';

-- 테이블 데이터 HelloCharger.tENVv2doRegiChargeHistory:~0 rows (대략적) 내보내기
DELETE FROM `tENVv2doRegiChargeHistory`;
/*!40000 ALTER TABLE `tENVv2doRegiChargeHistory` DISABLE KEYS */;
/*!40000 ALTER TABLE `tENVv2doRegiChargeHistory` ENABLE KEYS */;

-- 테이블 HelloCharger.tENVv2doRegiUsageHistory 구조 내보내기
CREATE TABLE IF NOT EXISTS `tENVv2doRegiUsageHistory` (
  `idx` int(11) NOT NULL AUTO_INCREMENT,
  `flag` tinyint(1) NOT NULL DEFAULT 0 COMMENT '해결여부 0: 대기, 1: 전송완료',
  `sid` varchar(50) DEFAULT NULL,
  `cid` varchar(50) DEFAULT NULL,
  `tbid` varchar(50) DEFAULT NULL,
  `tsdt` varchar(50) DEFAULT NULL,
  `tedt` varchar(50) DEFAULT NULL,
  `pow` varchar(50) DEFAULT NULL,
  `mon` varchar(50) DEFAULT NULL,
  `rcvdate` varchar(50) DEFAULT NULL,
  `error_log` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`idx`) USING BTREE,
  KEY `flag` (`flag`)
) ENGINE=InnoDB AUTO_INCREMENT=484 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='doRegiUsage에서 에러가 났을때 저장하는 에러로그 테이블 입니다.';

-- 테이블 데이터 HelloCharger.tENVv2doRegiUsageHistory:~0 rows (대략적) 내보내기
DELETE FROM `tENVv2doRegiUsageHistory`;
/*!40000 ALTER TABLE `tENVv2doRegiUsageHistory` DISABLE KEYS */;
/*!40000 ALTER TABLE `tENVv2doRegiUsageHistory` ENABLE KEYS */;

-- 테이블 HelloCharger.tEVCChargerFirmware 구조 내보내기
CREATE TABLE IF NOT EXISTS `tEVCChargerFirmware` (
  `seqno` int(11) NOT NULL AUTO_INCREMENT,
  `statId` varchar(8) NOT NULL DEFAULT '',
  `chargerId` varchar(2) NOT NULL DEFAULT '',
  `serialNumber` varchar(25) DEFAULT NULL,
  `location` varchar(400) DEFAULT '' COMMENT 'firmware file 위치',
  `retries` int(6) DEFAULT 0 COMMENT '재시도 횟수',
  `retrieveDate` timestamp NULL DEFAULT (current_timestamp() + interval 9 hour),
  `retryInterval` int(10) DEFAULT 0 COMMENT '재시도 간격 시간',
  `firmwareVersion` varchar(20) DEFAULT '' COMMENT 'updatefirmware 시작은 FIRST',
  `status` varchar(30) DEFAULT '' COMMENT 'firmware upgrade 상태',
  `timestamp` timestamp NOT NULL DEFAULT (current_timestamp() + interval 9 hour),
  PRIMARY KEY (`seqno`),
  KEY `uEVCChargerFirmware_idx1` (`statId`,`chargerId`,`serialNumber`)
) ENGINE=InnoDB AUTO_INCREMENT=8202 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 HelloCharger.tEVCChargerFirmware:~0 rows (대략적) 내보내기
DELETE FROM `tEVCChargerFirmware`;
/*!40000 ALTER TABLE `tEVCChargerFirmware` DISABLE KEYS */;
/*!40000 ALTER TABLE `tEVCChargerFirmware` ENABLE KEYS */;

-- 테이블 HelloCharger.tEVCChargerInfo 구조 내보내기
CREATE TABLE IF NOT EXISTS `tEVCChargerInfo` (
  `SeqNo` int(11) NOT NULL AUTO_INCREMENT,
  `statId` varchar(8) NOT NULL,
  `chargerId` varchar(2) NOT NULL DEFAULT '00',
  `serialNumber` varchar(25) DEFAULT NULL,
  `powerType` varchar(20) DEFAULT NULL,
  `chargerType` int(2) unsigned DEFAULT 0,
  `status` int(1) DEFAULT 0 COMMENT '1 : 충전가능, 2 : 충전중, 3 : 고장/점검, 4 : 통신장애, 5 : 통신미연결',
  `chargerIP` varchar(16) DEFAULT '',
  `chargerPort` varchar(5) DEFAULT '',
  `chargerMac` varchar(17) DEFAULT '',
  `chargerModel` varchar(40) DEFAULT '',
  `chargerVersion` varchar(20) DEFAULT '' COMMENT '컨트롤보드 버전',
  `chargerFirmwareVersion` varchar(40) DEFAULT '' COMMENT '충전기 앱 버전',
  `chargePointStatus` varchar(20) DEFAULT '' COMMENT 'ChargePointStatus OCPP (Avaiable, Preparing, ...)',
  `chargePointErrorCode` varchar(30) DEFAULT '' COMMENT 'ChargePointErrorCode OCPP (ConnectorLockFailure, EVCommunicationError, ...)',
  `availabilityType` varchar(20) NOT NULL DEFAULT '' COMMENT 'ChangeAvailability OCPP (Inoperative, Operative, ...)',
  `statusUpdatedTime` timestamp NULL DEFAULT NULL COMMENT 'OCPP Notificatino ',
  `lastHeartbeatTime` timestamp NULL DEFAULT NULL COMMENT 'OCPP HeatBeat Time',
  `chargerLTERouterNo` varchar(20) DEFAULT '' COMMENT 'LTE Router No',
  `valid` tinyint(1) DEFAULT 0 COMMENT '0: invalid or 한전batch로 얻은 데이터, 1: valid ',
  `timestamp` timestamp NULL DEFAULT (current_timestamp() + interval 9 hour),
  PRIMARY KEY (`SeqNo`),
  KEY `serialNumber` (`serialNumber`),
  KEY `statId` (`statId`)
) ENGINE=InnoDB AUTO_INCREMENT=52522 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 HelloCharger.tEVCChargerInfo:~0 rows (대략적) 내보내기
DELETE FROM `tEVCChargerInfo`;
/*!40000 ALTER TABLE `tEVCChargerInfo` DISABLE KEYS */;
INSERT INTO `tEVCChargerInfo` (`SeqNo`, `statId`, `chargerId`, `serialNumber`, `powerType`, `chargerType`, `status`, `chargerIP`, `chargerPort`, `chargerMac`, `chargerModel`, `chargerVersion`, `chargerFirmwareVersion`, `chargePointStatus`, `chargePointErrorCode`, `availabilityType`, `statusUpdatedTime`, `lastHeartbeatTime`, `chargerLTERouterNo`, `valid`, `timestamp`) VALUES
	(1, '111111', '01', '11111101', '완속', 0, 0, '', '', '36-58-21-8E-7C-9A', '', '2.5', '', 'Available', '', '', '2025-04-29 13:54:50', NULL, '0', 0, '2025-03-10 05:57:45'),
	(2, '111111', '02', '11111102', '완속', 0, 0, '', '', '36-58-21-8E-7C-9A', '', '2.5', '', 'Available', '', '', '2025-04-29 13:54:50', NULL, '0', 0, '2025-03-10 05:57:45'),
	(3, '111111', '03', '11111103', '완속', 0, 0, '', '', '36-58-21-8E-7C-9A', '', '2.5', '', 'Available', '', '', '2025-04-29 13:54:50', NULL, '0', 0, '2025-03-10 05:57:45'),
	(4, '111111', '04', '11111104', '완속', 0, 0, '', '', '36-58-21-8E-7C-9A', '', '2.5', '', 'Available', '', '', '2025-04-29 13:54:50', NULL, '0', 0, '2025-03-10 05:57:45'),
	(5, '111111', '05', '11111105', '완속', 0, 0, '', '', '36-58-21-8E-7C-9A', '', '2.5', '', 'Available', '', '', '2025-04-29 13:54:50', NULL, '0', 0, '2025-03-10 05:57:45'),
	(6, '111111', '06', '11111106', '완속', 0, 0, '', '', '36-58-21-8E-7C-9A', '', '2.5', '', 'Available', '', '', '2025-04-29 13:54:50', NULL, '0', 0, '2025-03-10 05:57:45'),
	(7, '111111', '07', '11111107', '완속', 0, 0, '', '', '36-58-21-8E-7C-9A', '', '2.5', '', 'Available', '', '', '2025-04-29 13:54:50', NULL, '0', 0, '2025-03-10 05:57:45'),
	(8, '111111', '08', '11111108', '완속', 0, 0, '', '', '36-58-21-8E-7C-9A', '', '2.5', '', 'Available', '', '', '2025-04-29 13:54:50', NULL, '0', 0, '2025-03-10 05:57:45'),
	(9, '111111', '09', '11111109', '완속', 0, 0, '', '', '36-58-21-8E-7C-9A', '', '2.5', '', 'Available', '', '', '2025-04-29 13:54:50', NULL, '0', 0, '2025-03-10 05:57:45'),
	(10, '111111', '10', '11111110', '완속', 0, 0, '', '', '36-58-21-8E-7C-9A', '', '2.5', '', 'Available', '', '', '2025-04-29 13:54:50', NULL, '0', 0, '2025-03-10 05:57:45'),
	(11, '111111', '11', '11111111', '완속', 0, 0, '', '', '36-58-21-8E-7C-9A', '', '2.5', '', 'Available', '', '', '2025-04-29 13:54:50', NULL, '0', 0, '2025-03-10 05:57:45'),
	(12, '111111', '12', '11111112', '완속', 0, 0, '', '', '36-58-21-8E-7C-9A', '', '2.5', '', 'Available', '', '', '2025-04-29 13:54:50', NULL, '0', 0, '2025-03-10 05:57:45'),
	(13, '222222', '01', '22222201', '급속', 0, 0, '', '', '36-58-21-8E-7C-9A', '', '2.5', '', 'Available', '', '', '2025-04-29 13:54:50', NULL, '0', 0, '2025-03-10 05:57:45'),
	(14, '222222', '02', '22222202', '급속', 0, 0, '', '', '36-58-21-8E-7C-9A', '', '2.5', '', 'Available', '', '', '2025-04-29 13:54:50', NULL, '0', 0, '2025-03-10 05:57:45');
/*!40000 ALTER TABLE `tEVCChargerInfo` ENABLE KEYS */;

-- 테이블 HelloCharger.tEVCChargerMeterInfo 구조 내보내기
CREATE TABLE IF NOT EXISTS `tEVCChargerMeterInfo` (
  `seqNo` int(11) NOT NULL AUTO_INCREMENT,
  `statId` varchar(8) NOT NULL DEFAULT '',
  `chargerId` varchar(2) NOT NULL DEFAULT '',
  `serialNumber` varchar(25) DEFAULT NULL,
  `transactionid` int(11) DEFAULT 0,
  `context` varchar(30) DEFAULT '',
  `format` varchar(20) DEFAULT '',
  `location` varchar(20) DEFAULT '',
  `measurand` varchar(36) DEFAULT '',
  `phase` varchar(10) DEFAULT '',
  `unit` varchar(10) DEFAULT '',
  `value` varchar(10) DEFAULT '',
  `timestamp` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`seqNo`),
  UNIQUE KEY `serialNumber_measurand` (`serialNumber`,`measurand`)
) ENGINE=InnoDB AUTO_INCREMENT=616474 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 HelloCharger.tEVCChargerMeterInfo:~0 rows (대략적) 내보내기
DELETE FROM `tEVCChargerMeterInfo`;
/*!40000 ALTER TABLE `tEVCChargerMeterInfo` DISABLE KEYS */;
/*!40000 ALTER TABLE `tEVCChargerMeterInfo` ENABLE KEYS */;

-- 테이블 HelloCharger.tEVCChargerStatusHistory 구조 내보내기
CREATE TABLE IF NOT EXISTS `tEVCChargerStatusHistory` (
  `seqno` int(11) NOT NULL AUTO_INCREMENT,
  `statId` varchar(8) NOT NULL DEFAULT '',
  `chargerId` varchar(2) NOT NULL DEFAULT '',
  `serialNumber` varchar(25) DEFAULT '',
  `chargePointStatus` varchar(20) NOT NULL DEFAULT '',
  `chargePointErrorCode` varchar(30) NOT NULL DEFAULT '',
  `info` varchar(50) NOT NULL DEFAULT '',
  `availabilityType` varchar(20) NOT NULL DEFAULT '',
  `statusUpdatedTime` timestamp NOT NULL DEFAULT (current_timestamp() + interval 9 hour),
  PRIMARY KEY (`seqno`),
  KEY `uEVCChargerStatusHistory_idx1` (`statId`,`chargerId`,`serialNumber`)
) ENGINE=InnoDB AUTO_INCREMENT=15980852 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 HelloCharger.tEVCChargerStatusHistory:~0 rows (대략적) 내보내기
DELETE FROM `tEVCChargerStatusHistory`;
/*!40000 ALTER TABLE `tEVCChargerStatusHistory` DISABLE KEYS */;
/*!40000 ALTER TABLE `tEVCChargerStatusHistory` ENABLE KEYS */;

-- 테이블 HelloCharger.tEVCChargerTransactionInfo 구조 내보내기
CREATE TABLE IF NOT EXISTS `tEVCChargerTransactionInfo` (
  `seqNo` int(11) NOT NULL AUTO_INCREMENT,
  `serialNumber` varchar(25) DEFAULT NULL,
  `statId` varchar(8) DEFAULT '' COMMENT '충전소 ID',
  `chargerId` varchar(2) DEFAULT '' COMMENT '충전기 ID',
  `cardNo` varchar(16) DEFAULT '' COMMENT '회원카드번호',
  `bid` varchar(2) DEFAULT '' COMMENT '기관ID',
  `payMethod` varchar(20) DEFAULT '' COMMENT '결제수단',
  `meterStart` int(10) DEFAULT 0 COMMENT '시작 meter',
  `reservationId` int(10) DEFAULT 0,
  `transactionId` int(11) DEFAULT 0 COMMENT 'central system이 생성',
  `timestamp` timestamp NOT NULL DEFAULT (current_timestamp() + interval 9 hour),
  `meterStop` int(10) DEFAULT 0 COMMENT '종료 meter',
  `reason` varchar(20) DEFAULT '',
  PRIMARY KEY (`seqNo`),
  KEY `transactionId` (`transactionId`)
) ENGINE=InnoDB AUTO_INCREMENT=260467 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='occp startTransaction, stopTransaction 명령에 관한 DB\r\nwebadmin화면에 표시하지는 않고 있음.';

-- 테이블 데이터 HelloCharger.tEVCChargerTransactionInfo:~2 rows (대략적) 내보내기
DELETE FROM `tEVCChargerTransactionInfo`;
/*!40000 ALTER TABLE `tEVCChargerTransactionInfo` DISABLE KEYS */;
INSERT INTO `tEVCChargerTransactionInfo` (`seqNo`, `serialNumber`, `statId`, `chargerId`, `cardNo`, `bid`, `payMethod`, `meterStart`, `reservationId`, `transactionId`, `timestamp`, `meterStop`, `reason`) VALUES
	(260465, '11111101', '111111', '01', '', '', '', 500, 0, 222222, now(), 0, ''),
	(260466, '11111101', '111111', '01', '', '', '', 0, 0, 222222, now(), 600, 'Local');
/*!40000 ALTER TABLE `tEVCChargerTransactionInfo` ENABLE KEYS */;

-- 테이블 HelloCharger.tEVCChargerTransactionInfo2 구조 내보내기
CREATE TABLE IF NOT EXISTS `tEVCChargerTransactionInfo2` (
  `seqNo` int(11) NOT NULL AUTO_INCREMENT,
  `serialNumber` varchar(25) DEFAULT NULL,
  `cardNo` varchar(16) DEFAULT '' COMMENT '회원카드번호',
  `meterStart` int(10) DEFAULT 0 COMMENT '시작 meter',
  `reservationId` int(10) DEFAULT 0,
  `transactionId` int(11) NOT NULL DEFAULT 0 COMMENT 'central system이 생성',
  `timestamp` timestamp NOT NULL DEFAULT (current_timestamp() + interval 9 hour),
  `meterStop` int(10) DEFAULT 0 COMMENT '종료 meter',
  `reason` varchar(20) DEFAULT '',
  PRIMARY KEY (`transactionId`),
  UNIQUE KEY `seqNo` (`seqNo`)
) ENGINE=InnoDB AUTO_INCREMENT=149982 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='occp startTransaction, stopTransaction 명령에 관한 DB\r\ntEVCChargerTransactionInfo의 PK가 transactionId가 아니라 seqNo로 설정되어 있어서 정상적인 기능이 되지 않아 새로운 테이블 생성';

-- 테이블 데이터 HelloCharger.tEVCChargerTransactionInfo2:~0 rows (대략적) 내보내기
DELETE FROM `tEVCChargerTransactionInfo2`;
/*!40000 ALTER TABLE `tEVCChargerTransactionInfo2` DISABLE KEYS */;
/*!40000 ALTER TABLE `tEVCChargerTransactionInfo2` ENABLE KEYS */;

-- 테이블 HelloCharger.tEVCStationInfo 구조 내보내기
CREATE TABLE IF NOT EXISTS `tEVCStationInfo` (
  `seqNo` int(11) NOT NULL AUTO_INCREMENT,
  `statId` varchar(8) NOT NULL,
  `statName` varchar(100) NOT NULL,
  `ownerName` varchar(20) DEFAULT NULL,
  `adminName` varchar(20) DEFAULT NULL,
  `adminType` tinyint(2) DEFAULT 0,
  `adminTelno` varchar(20) DEFAULT NULL,
  `postcode` varchar(8) DEFAULT NULL,
  `addr` varchar(150) DEFAULT NULL,
  `addr2` varchar(60) DEFAULT NULL,
  `stationType` tinyint(2) NOT NULL DEFAULT 0 COMMENT '1: 공공시설, 2:주차시설, 3:휴게시설, 4:관광시설, 5:상업시설, 6:차량정비시설, 7:기타시설',
  `stationDetailType` tinyint(2) NOT NULL DEFAULT 0 COMMENT '1:''군부대'', 2:''사업장(교육)'', 3:''병원'', 4:''학교'', 5:''경기장'', 6:''아파트'', 7:''사찰'', 8:''수련원'', 9:''경찰서'', 10:''기타''',
  `stationOperationType` tinyint(2) unsigned NOT NULL DEFAULT 0 COMMENT '1:''완전개방'', 2:''부분개방''',
  `latitude` varchar(20) NOT NULL,
  `longitude` varchar(20) NOT NULL,
  `useTime` varchar(50) DEFAULT NULL,
  `businessId` varchar(4) DEFAULT NULL,
  `businessName` varchar(50) DEFAULT NULL,
  `businessTel` varchar(20) DEFAULT NULL,
  `zipcode` varchar(2) DEFAULT NULL,
  `parkingFree` varchar(1) DEFAULT NULL,
  `note` varchar(200) DEFAULT NULL,
  `member_id` varchar(12) DEFAULT '' COMMENT '회원사ID',
  `member_id2` varchar(12) DEFAULT '' COMMENT '회원사ID : 서브계정',
  PRIMARY KEY (`seqNo`),
  UNIQUE KEY `statId` (`statId`),
  KEY `index_name_addr` (`statName`,`addr`),
  KEY `latitude` (`latitude`)
) ENGINE=InnoDB AUTO_INCREMENT=22665 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 HelloCharger.tEVCStationInfo:~0 rows (대략적) 내보내기
DELETE FROM `tEVCStationInfo`;
/*!40000 ALTER TABLE `tEVCStationInfo` DISABLE KEYS */;
INSERT INTO `tEVCStationInfo` (`seqNo`, `statId`, `statName`, `ownerName`, `adminName`, `adminType`, `adminTelno`, `postcode`, `addr`, `addr2`, `stationType`, `stationDetailType`, `stationOperationType`, `latitude`, `longitude`, `useTime`, `businessId`, `businessName`, `businessTel`, `zipcode`, `parkingFree`, `note`, `member_id`, `member_id2`) VALUES
	(22664, '111111', '완속', '', '', 0, NULL, '', '', '', 0, 0, 0, '', '', '', '', '', '', '', '', '', 'local', ''),
	(22665, '222222', '급속', '', '', 0, NULL, '', '', '', 0, 0, 0, '', '', '', '', '', '', '', '', '', 'local', '');
/*!40000 ALTER TABLE `tEVCStationInfo` ENABLE KEYS */;

-- 테이블 HelloCharger.tEVCTransactionInfo 구조 내보내기
CREATE TABLE IF NOT EXISTS `tEVCTransactionInfo` (
  `SeqNo` int(11) NOT NULL AUTO_INCREMENT,
  `OrderNo` varchar(10) NOT NULL DEFAULT '',
  `TransactionCode` varchar(20) NOT NULL DEFAULT '',
  `statId` varchar(8) NOT NULL DEFAULT '',
  `chargerId` varchar(2) NOT NULL DEFAULT '',
  `chargerStatus` varchar(2) NOT NULL DEFAULT '',
  `UserID` int(11) DEFAULT NULL,
  `bid` varchar(2) DEFAULT NULL COMMENT '기관 ID',
  `TransactionCardNo` varchar(20) NOT NULL DEFAULT '',
  `ChargerQuantity` int(10) DEFAULT 0 COMMENT 'wh',
  `ChargerPrice` int(10) DEFAULT 0,
  `ChargerTime` float DEFAULT NULL,
  `ChargeStartTime` timestamp NULL DEFAULT NULL,
  `ChargeEndTime` timestamp NULL DEFAULT NULL,
  `PaymentMethod` varchar(20) DEFAULT '',
  `updatedTime` varchar(14) DEFAULT NULL,
  PRIMARY KEY (`SeqNo`),
  KEY `TransactionCardNo` (`TransactionCardNo`)
) ENGINE=InnoDB AUTO_INCREMENT=101254 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='{backend}/charge/registerChargeHistory API 호출에 관한 DB\r\n<-- 충전이력등록';

-- 테이블 데이터 HelloCharger.tEVCTransactionInfo:~0 rows (대략적) 내보내기
DELETE FROM `tEVCTransactionInfo`;
/*!40000 ALTER TABLE `tEVCTransactionInfo` DISABLE KEYS */;
INSERT INTO `tEVCTransactionInfo` (`SeqNo`, `OrderNo`, `TransactionCode`, `statId`, `chargerId`, `chargerStatus`, `UserID`, `bid`, `TransactionCardNo`, `ChargerQuantity`, `ChargerPrice`, `ChargerTime`, `ChargeStartTime`, `ChargeEndTime`, `PaymentMethod`, `updatedTime`) VALUES
	(101250, '', '222222', '111111', '01', '', NULL, NULL, '12345678', 5, 6, NULL, now(), now(), '', NULL),
	(101251, '', '222222', '222222', '01', '', NULL, NULL, '12345678', 5, 6, NULL, now(), now(), '', NULL);
/*!40000 ALTER TABLE `tEVCTransactionInfo` ENABLE KEYS */;

-- 테이블 HelloCharger.tInstallationInfo 구조 내보내기
CREATE TABLE IF NOT EXISTS `tInstallationInfo` (
  `SeqNo` int(11) NOT NULL AUTO_INCREMENT,
  `applyDate` timestamp NULL DEFAULT NULL,
  `applicant` varchar(10) NOT NULL,
  `corporate_name` varchar(20) NOT NULL,
  `applicant_tel_no` varchar(16) NOT NULL,
  `applicant_mobile_no` varchar(16) NOT NULL,
  `applicant_email` varchar(30) NOT NULL,
  `applicant_region` varchar(20) DEFAULT '',
  `applicant_lot` varchar(20) DEFAULT '',
  `operation_type` varchar(20) DEFAULT '',
  `worker` varchar(20) DEFAULT '',
  `status` tinyint(1) DEFAULT 0,
  `status_date` timestamp NULL DEFAULT NULL,
  `sent_email1` tinyint(1) DEFAULT 0,
  `sent_email2` tinyint(1) DEFAULT 0,
  `inspector` varchar(20) DEFAULT '',
  `member_id` varchar(12) DEFAULT NULL,
  `updateTime` timestamp NOT NULL DEFAULT (current_timestamp() + interval 9 hour),
  PRIMARY KEY (`SeqNo`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='설치 상황 테이블';

-- 테이블 데이터 HelloCharger.tInstallationInfo:~0 rows (대략적) 내보내기
DELETE FROM `tInstallationInfo`;
/*!40000 ALTER TABLE `tInstallationInfo` DISABLE KEYS */;
/*!40000 ALTER TABLE `tInstallationInfo` ENABLE KEYS */;

-- 테이블 HelloCharger.tLocalUserInfo 구조 내보내기
CREATE TABLE IF NOT EXISTS `tLocalUserInfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `member_id` varchar(50) DEFAULT NULL,
  `kind` varchar(50) DEFAULT NULL,
  `card_stop` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `car_type` varchar(50) DEFAULT NULL,
  `car_number` varchar(50) DEFAULT NULL,
  `card_number` varchar(50) DEFAULT NULL,
  `complex` varchar(50) DEFAULT NULL,
  `dong` varchar(50) DEFAULT NULL,
  `ho` varchar(50) DEFAULT NULL,
  `phone_number` varchar(50) DEFAULT NULL,
  `delete_flag` varchar(50) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 HelloCharger.tLocalUserInfo:~0 rows (대략적) 내보내기
DELETE FROM `tLocalUserInfo`;
/*!40000 ALTER TABLE `tLocalUserInfo` DISABLE KEYS */;
INSERT INTO `tLocalUserInfo` (`id`, `member_id`, `kind`, `card_stop`, `name`, `car_type`, `car_number`, `card_number`, `complex`, `dong`, `ho`, `phone_number`, `delete_flag`) VALUES
	(1, 'local', '과금', 'N', 'castpro', '코나', '123가 1234', '12345678', '1', '1', '101', '01012345678', '0');
/*!40000 ALTER TABLE `tLocalUserInfo` ENABLE KEYS */;

-- 테이블 HelloCharger.tMalfunctionInfo 구조 내보내기
CREATE TABLE IF NOT EXISTS `tMalfunctionInfo` (
  `statId` varchar(8) NOT NULL,
  `chargerId` varchar(10) NOT NULL,
  `reportDate` timestamp NOT NULL DEFAULT current_timestamp(),
  `part` varchar(16) NOT NULL,
  `type` varchar(16) NOT NULL,
  `report_content` varchar(1000) DEFAULT NULL COMMENT '고장신고내용',
  PRIMARY KEY (`statId`,`chargerId`,`reportDate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='고장 상황 테이블';

-- 테이블 데이터 HelloCharger.tMalfunctionInfo:~0 rows (대략적) 내보내기
DELETE FROM `tMalfunctionInfo`;
/*!40000 ALTER TABLE `tMalfunctionInfo` DISABLE KEYS */;
/*!40000 ALTER TABLE `tMalfunctionInfo` ENABLE KEYS */;

-- 테이블 HelloCharger.tMemberHasStation 구조 내보내기
CREATE TABLE IF NOT EXISTS `tMemberHasStation` (
  `seqNo` int(11) NOT NULL AUTO_INCREMENT,
  `member_id` varchar(12) NOT NULL,
  `statId` varchar(8) NOT NULL,
  `updateTime` timestamp NOT NULL DEFAULT (current_timestamp() + interval 9 hour),
  PRIMARY KEY (`seqNo`) USING BTREE,
  UNIQUE KEY `uMemberHasStation_idx1` (`member_id`,`statId`)
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 HelloCharger.tMemberHasStation:~0 rows (대략적) 내보내기
DELETE FROM `tMemberHasStation`;
/*!40000 ALTER TABLE `tMemberHasStation` DISABLE KEYS */;
/*!40000 ALTER TABLE `tMemberHasStation` ENABLE KEYS */;

-- 테이블 HelloCharger.tMemberInfo 구조 내보내기
CREATE TABLE IF NOT EXISTS `tMemberInfo` (
  `member_id` varchar(12) NOT NULL,
  `member_name` varchar(20) DEFAULT NULL,
  `member_password` varchar(32) DEFAULT NULL,
  `member_telno` varchar(20) NOT NULL,
  `member_postcode` varchar(8) NOT NULL,
  `member_addr1` varchar(60) DEFAULT NULL,
  `member_addr2` varchar(60) DEFAULT NULL,
  `member_admin_name` varchar(20) DEFAULT NULL,
  `member_admin_telno` varchar(20) DEFAULT NULL,
  `member_admin_email` varchar(40) DEFAULT NULL,
  `member_note` varchar(100) DEFAULT NULL,
  `member_bid` varchar(4) DEFAULT '' COMMENT '환경부 BID',
  `member_bkey` varchar(16) DEFAULT '' COMMENT '환경부 BKEY',
  `member_bid_valid` tinyint(4) NOT NULL DEFAULT 1,
  `member_env_integrated` tinyint(1) NOT NULL DEFAULT 1 COMMENT '환경부 연동 유무, true:연동함',
  `member_role` tinyint(1) NOT NULL DEFAULT 2 COMMENT '계정권한 본계정 = 2, 이외 계정 = n++',
  `member_parent` varchar(12) DEFAULT NULL COMMENT '계정권한 본계정 ID',
  `member_deleteFlag` tinyint(1) NOT NULL DEFAULT 0,
  `updateTime` timestamp NOT NULL DEFAULT (current_timestamp() + interval 9 hour),
  PRIMARY KEY (`member_id`),
  KEY `uMemberInfo_idx1` (`member_name`,`member_addr1`,`member_admin_name`,`member_admin_telno`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 HelloCharger.tMemberInfo:~0 rows (대략적) 내보내기
DELETE FROM `tMemberInfo`;
/*!40000 ALTER TABLE `tMemberInfo` DISABLE KEYS */;
INSERT INTO `tMemberInfo` (`member_id`, `member_name`, `member_password`, `member_telno`, `member_postcode`, `member_addr1`, `member_addr2`, `member_admin_name`, `member_admin_telno`, `member_admin_email`, `member_note`, `member_bid`, `member_bkey`, `member_bid_valid`, `member_env_integrated`, `member_role`, `member_parent`, `member_deleteFlag`, `updateTime`) VALUES
	('local', '로컬', 'f5ddaf0ca7929578b408c909429f68f2', '020000', '02', NULL, NULL, NULL, NULL, NULL, NULL, 'LO', '', 1, 1, 2, NULL, 0, '2025-04-10 11:32:46');
/*!40000 ALTER TABLE `tMemberInfo` ENABLE KEYS */;

-- 테이블 HelloCharger.tMemberRoamingInfo 구조 내보내기
CREATE TABLE IF NOT EXISTS `tMemberRoamingInfo` (
  `member_id` varchar(12) NOT NULL COMMENT '회원사',
  `bid` varchar(2) NOT NULL COMMENT '기관 ID',
  `group_name` varchar(50) DEFAULT NULL,
  `regdate` datetime NOT NULL DEFAULT (current_timestamp() + interval 9 hour) COMMENT '생성날짜',
  `delete_flag` tinyint(1) NOT NULL DEFAULT 0 COMMENT '삭제유무 (0: 정상, 1: 삭제)',
  PRIMARY KEY (`member_id`,`bid`) USING BTREE,
  KEY `FK_tMemberRoamingInfo_tRoamingInfo` (`bid`),
  KEY `group_name` (`group_name`),
  CONSTRAINT `FK_tMemberRoamingInfo_tRoamingInfo` FOREIGN KEY (`bid`) REFERENCES `tRoamingInfo` (`bid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 HelloCharger.tMemberRoamingInfo:~0 rows (대략적) 내보내기
DELETE FROM `tMemberRoamingInfo`;
/*!40000 ALTER TABLE `tMemberRoamingInfo` DISABLE KEYS */;
INSERT INTO `tMemberRoamingInfo` (`member_id`, `bid`, `group_name`, `regdate`, `delete_flag`) VALUES
	('local', 'LO', NULL, '2025-05-19 14:09:58', 0);
/*!40000 ALTER TABLE `tMemberRoamingInfo` ENABLE KEYS */;

-- 테이블 HelloCharger.tniceBilling 구조 내보내기
CREATE TABLE IF NOT EXISTS `tniceBilling` (
  `email` varchar(30) NOT NULL,
  `member_id` varchar(12) NOT NULL,
  `user_card_number` varchar(16) NOT NULL,
  `ResultCode` varchar(4) DEFAULT NULL,
  `ResultMsg` varchar(100) DEFAULT NULL,
  `TID` varchar(30) DEFAULT NULL,
  `BID` varchar(30) DEFAULT NULL,
  `AuthDate` varchar(8) DEFAULT NULL,
  `CardCode` varchar(3) DEFAULT NULL,
  `CardName` varchar(20) DEFAULT NULL,
  `CardCl` varchar(1) DEFAULT NULL,
  `AcquCardCode` varchar(4) DEFAULT NULL,
  `AcquCardName` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`email`,`member_id`,`user_card_number`) USING BTREE,
  KEY `TID` (`TID`,`BID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 HelloCharger.tniceBilling:~0 rows (대략적) 내보내기
DELETE FROM `tniceBilling`;
/*!40000 ALTER TABLE `tniceBilling` DISABLE KEYS */;
/*!40000 ALTER TABLE `tniceBilling` ENABLE KEYS */;

-- 테이블 HelloCharger.tnicePayment 구조 내보내기
CREATE TABLE IF NOT EXISTS `tnicePayment` (
  `ResultCode` varchar(4) DEFAULT NULL,
  `ResultMsg` varchar(100) DEFAULT NULL,
  `TID` varchar(30) NOT NULL,
  `Moid` varchar(64) DEFAULT NULL,
  `Amt` varchar(12) DEFAULT NULL,
  `AuthCode` varchar(30) DEFAULT NULL,
  `AuthDate` varchar(12) DEFAULT NULL,
  `AcquCardCode` varchar(4) DEFAULT NULL,
  `AcquCardName` varchar(20) DEFAULT NULL,
  `CardNo` varchar(20) DEFAULT NULL,
  `CardCode` varchar(4) DEFAULT NULL,
  `CardName` varchar(20) DEFAULT NULL,
  `CardQuota` varchar(2) DEFAULT NULL,
  `CardCl` varchar(1) DEFAULT NULL,
  `CardInterest` varchar(1) DEFAULT NULL,
  `CcPartCl` varchar(1) DEFAULT NULL,
  `MallReserved` varchar(500) DEFAULT NULL,
  `Cancle` int(1) NOT NULL DEFAULT 0 COMMENT '취소여부 (0: 정상, 1: 취소)',
  PRIMARY KEY (`TID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 HelloCharger.tnicePayment:~0 rows (대략적) 내보내기
DELETE FROM `tnicePayment`;
/*!40000 ALTER TABLE `tnicePayment` DISABLE KEYS */;
/*!40000 ALTER TABLE `tnicePayment` ENABLE KEYS */;

-- 테이블 HelloCharger.tNotice 구조 내보내기
CREATE TABLE IF NOT EXISTS `tNotice` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL,
  `author` varchar(20) NOT NULL,
  `regdate` varchar(16) NOT NULL,
  `contents` varchar(10000) NOT NULL,
  `flag` varchar(1) DEFAULT NULL,
  `updateTime` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 HelloCharger.tNotice:~0 rows (대략적) 내보내기
DELETE FROM `tNotice`;
/*!40000 ALTER TABLE `tNotice` DISABLE KEYS */;
/*!40000 ALTER TABLE `tNotice` ENABLE KEYS */;

-- 테이블 HelloCharger.tPaymentInfo 구조 내보내기
CREATE TABLE IF NOT EXISTS `tPaymentInfo` (
  `seqNo` int(11) NOT NULL AUTO_INCREMENT,
  `statId` varchar(8) NOT NULL COMMENT '충전소 ID',
  `chargerId` varchar(2) NOT NULL COMMENT '충전기 ID',
  `Dpt_Id` varchar(10) DEFAULT '' COMMENT '결제단말기 식별 번호',
  `paymentMethod` varchar(12) DEFAULT 'credit' COMMENT '결제수단 (credit:신용카드, env:환경부회원, hellocharger:헬로우차저회원, roaming:로밍회원)',
  `AuthNum` varchar(12) DEFAULT '' COMMENT '승인번호',
  `Authdate` varchar(12) DEFAULT '' COMMENT '승인거래일시(YYMMDDHHmmss)',
  `CardName` varchar(20) DEFAULT '' COMMENT '결제 카드 이름',
  `CardNo` varchar(16) DEFAULT '' COMMENT '결제 카드 번호',
  `FranchiseID` varchar(15) DEFAULT '' COMMENT '가맹점 번호',
  `Wh` float(10,2) DEFAULT 0.00 COMMENT '사용 Wh',
  `kWh` float(10,2) DEFAULT 0.00,
  `Message1` varchar(100) DEFAULT '' COMMENT '승인시: 카드종류명, 거절시: 거절사유',
  `Message2` varchar(100) DEFAULT '' COMMENT '승인시: OK, 거절시: 거절사유',
  `PurchaseName` varchar(16) DEFAULT '' COMMENT '매입사명',
  `Status` varchar(1) DEFAULT '' COMMENT '승인결과',
  `Amount` int(12) DEFAULT 0 COMMENT '공급금액',
  `TaxAmount` int(12) DEFAULT 0 COMMENT '부가세',
  `TotalAmount` int(12) DEFAULT 0 COMMENT '결제금액',
  `messageType` varchar(2) DEFAULT '' COMMENT '메시지 구분 (1:선결제, 2:실결제)',
  `TransType` varchar(2) DEFAULT '' COMMENT '트랜잭션 유형(t1:결제, u1:결제취소, f1: 결제취소실패)',
  `idTag` varchar(20) DEFAULT '' COMMENT 'ocpp idTag, 회원카드번호 [LENGTH:20]',
  `updateTime` timestamp NULL DEFAULT (current_timestamp() + interval 9 hour),
  PRIMARY KEY (`seqNo`),
  KEY `statId` (`statId`,`chargerId`,`Dpt_Id`),
  KEY `paymentMethod` (`paymentMethod`)
) ENGINE=InnoDB AUTO_INCREMENT=145969 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='신용카드 결제 이력 내역';

-- 테이블 데이터 HelloCharger.tPaymentInfo:~0 rows (대략적) 내보내기
DELETE FROM `tPaymentInfo`;
/*!40000 ALTER TABLE `tPaymentInfo` DISABLE KEYS */;
/*!40000 ALTER TABLE `tPaymentInfo` ENABLE KEYS */;

-- 테이블 HelloCharger.tRoamingCard 구조 내보내기
CREATE TABLE IF NOT EXISTS `tRoamingCard` (
  `bid` varchar(50) DEFAULT NULL COMMENT '로밍카드 bid',
  `group_name` varchar(50) NOT NULL COMMENT '로밍그룹 idx'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 HelloCharger.tRoamingCard:~0 rows (대략적) 내보내기
DELETE FROM `tRoamingCard`;
/*!40000 ALTER TABLE `tRoamingCard` DISABLE KEYS */;
/*!40000 ALTER TABLE `tRoamingCard` ENABLE KEYS */;

-- 테이블 HelloCharger.tRoamingGroup 구조 내보내기
CREATE TABLE IF NOT EXISTS `tRoamingGroup` (
  `idx` int(11) NOT NULL AUTO_INCREMENT,
  `group_name` varchar(50) NOT NULL,
  `startTime` tinyint(4) NOT NULL DEFAULT 0,
  `endTime` tinyint(4) NOT NULL DEFAULT 0,
  `regularPrice` float NOT NULL DEFAULT 320 COMMENT '완속 단가',
  `fastPrice` float NOT NULL DEFAULT 430 COMMENT '급속 단가',
  PRIMARY KEY (`idx`,`group_name`),
  KEY `startTime` (`startTime`)
) ENGINE=InnoDB AUTO_INCREMENT=170 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='로밍단가 그룹';

-- 테이블 데이터 HelloCharger.tRoamingGroup:~0 rows (대략적) 내보내기
DELETE FROM `tRoamingGroup`;
/*!40000 ALTER TABLE `tRoamingGroup` DISABLE KEYS */;
/*!40000 ALTER TABLE `tRoamingGroup` ENABLE KEYS */;

-- 테이블 HelloCharger.tRoamingInfo 구조 내보내기
CREATE TABLE IF NOT EXISTS `tRoamingInfo` (
  `bid` varchar(2) NOT NULL,
  `member_id` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`bid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 HelloCharger.tRoamingInfo:~0 rows (대략적) 내보내기
DELETE FROM `tRoamingInfo`;
/*!40000 ALTER TABLE `tRoamingInfo` DISABLE KEYS */;
INSERT INTO `tRoamingInfo` (`bid`, `member_id`) VALUES
	('LO', 'local');
/*!40000 ALTER TABLE `tRoamingInfo` ENABLE KEYS */;

-- 테이블 HelloCharger.tStationUnitPriceInfo 구조 내보내기
CREATE TABLE IF NOT EXISTS `tStationUnitPriceInfo` (
  `member_id` varchar(12) NOT NULL,
  `statId` varchar(8) NOT NULL,
  `unitPriceVersionNo` int(5) unsigned zerofill NOT NULL DEFAULT 00001 COMMENT '단가 설정 번호, 시퀸스번호',
  `startTime` varchar(2) NOT NULL,
  `endTime` varchar(2) NOT NULL,
  `castproPrice` float(10,2) NOT NULL DEFAULT 300.00 COMMENT '회원 단가',
  `otherPrice` float(10,2) NOT NULL DEFAULT 300.00 COMMENT '비회원 단가',
  `envPrice` float(10,2) NOT NULL DEFAULT 300.00 COMMENT '환경부 단가',
  `roamingPrice` float(10,2) NOT NULL DEFAULT 300.00 COMMENT '로딩(제휴사) 단가',
  PRIMARY KEY (`member_id`,`statId`,`startTime`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 HelloCharger.tStationUnitPriceInfo:~24 rows (대략적) 내보내기
DELETE FROM `tStationUnitPriceInfo`;
/*!40000 ALTER TABLE `tStationUnitPriceInfo` DISABLE KEYS */;
/*!40000 ALTER TABLE `tStationUnitPriceInfo` ENABLE KEYS */;

-- 테이블 HelloCharger.tUnitPriceInfo 구조 내보내기
CREATE TABLE IF NOT EXISTS `tUnitPriceInfo` (
  `seqNo` int(11) NOT NULL AUTO_INCREMENT,
  `member_id` varchar(12) NOT NULL,
  `unitPriceVersionNo` int(5) unsigned zerofill NOT NULL DEFAULT 00001 COMMENT '단가 설정 번호, 시퀸스번호',
  `startTime` varchar(2) NOT NULL,
  `endTime` varchar(2) NOT NULL,
  `castproDefaultPrice` float(10,2) NOT NULL DEFAULT 300.00 COMMENT '회원단가',
  `otherPrice` float(10,2) NOT NULL DEFAULT 300.00 COMMENT '비회원 단가',
  `envPrice` float(10,2) NOT NULL DEFAULT 324.40 COMMENT '환경부 단가',
  `roamingPrice` float(10,2) NOT NULL DEFAULT 300.00 COMMENT '로딩(제휴사) 단가',
  `lowPrice1` float(10,2) NOT NULL DEFAULT 69.10,
  `lowPrice2` float(10,2) NOT NULL DEFAULT 56.30,
  `lowPrice3` float(10,2) NOT NULL DEFAULT 63.30,
  `lowPrice4` float(10,2) NOT NULL DEFAULT 145.20,
  `highPrice1` float(10,2) NOT NULL DEFAULT 63.00,
  `highPrice2` float(10,2) NOT NULL DEFAULT 51.40,
  `highPrice3` float(10,2) NOT NULL DEFAULT 57.70,
  `highPrice4` float(10,2) NOT NULL DEFAULT 110.60,
  `updateTime` timestamp NOT NULL DEFAULT (current_timestamp() + interval 9 hour),
  PRIMARY KEY (`seqNo`) USING BTREE,
  UNIQUE KEY `flag` (`member_id`,`startTime`,`endTime`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=853 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 HelloCharger.tUnitPriceInfo:~48 rows (대략적) 내보내기
DELETE FROM `tUnitPriceInfo`;
/*!40000 ALTER TABLE `tUnitPriceInfo` DISABLE KEYS */;
INSERT INTO `tUnitPriceInfo` (`seqNo`, `member_id`, `unitPriceVersionNo`, `startTime`, `endTime`, `castproDefaultPrice`, `otherPrice`, `envPrice`, `roamingPrice`, `lowPrice1`, `lowPrice2`, `lowPrice3`, `lowPrice4`, `highPrice1`, `highPrice2`, `highPrice3`, `highPrice4`, `updateTime`) VALUES
	(805, 'admin', 00005, '23', '24', 302.30, 312.30, 300.00, 300.00, 69.10, 56.30, 63.30, 145.20, 63.00, 51.40, 57.70, 901.10, '2022-02-04 18:00:13'),
	(806, 'admin', 00005, '22', '23', 302.20, 300.00, 300.00, 300.00, 69.10, 56.30, 63.30, 145.20, 103.10, 51.40, 57.70, 110.60, '2022-02-03 12:35:52'),
	(807, 'admin', 00005, '21', '22', 302.10, 300.00, 300.00, 300.00, 69.10, 56.30, 63.30, 145.20, 103.10, 51.40, 57.70, 110.60, '2022-02-03 12:35:47'),
	(808, 'admin', 00005, '20', '21', 302.00, 300.00, 300.00, 300.00, 69.10, 56.30, 63.30, 145.20, 103.10, 51.40, 57.70, 110.60, '2022-02-03 12:35:41'),
	(809, 'admin', 00005, '19', '20', 301.90, 300.00, 300.00, 300.00, 69.10, 56.30, 63.30, 145.20, 103.10, 51.40, 57.70, 110.60, '2022-02-03 12:35:37'),
	(810, 'admin', 00005, '18', '19', 301.80, 300.00, 300.00, 300.00, 69.10, 56.30, 63.30, 145.20, 103.10, 51.40, 57.70, 110.60, '2022-02-03 12:35:32'),
	(811, 'admin', 00005, '17', '18', 301.70, 300.00, 300.00, 300.00, 69.10, 66.30, 64.30, 143.20, 103.10, 52.40, 58.70, 113.60, '2022-02-03 12:35:28'),
	(812, 'admin', 00005, '16', '17', 301.60, 300.00, 300.00, 300.00, 79.10, 56.30, 63.30, 145.20, 124.40, 51.40, 57.70, 110.60, '2022-02-03 12:35:22'),
	(813, 'admin', 00005, '15', '16', 122.10, 300.00, 300.00, 300.00, 69.10, 56.30, 63.30, 145.20, 124.40, 51.40, 57.70, 110.60, '2022-02-03 12:35:17'),
	(814, 'admin', 00005, '14', '15', 301.40, 300.00, 300.00, 300.00, 69.10, 56.30, 63.30, 145.20, 124.40, 51.40, 57.70, 110.60, '2022-02-03 12:35:10'),
	(815, 'admin', 00005, '13', '14', 301.30, 300.00, 300.00, 300.00, 69.10, 56.30, 63.30, 145.20, 124.40, 51.40, 57.70, 110.60, '2022-02-03 12:35:01'),
	(816, 'admin', 00005, '12', '13', 300.10, 300.00, 300.00, 300.00, 69.10, 56.30, 63.30, 145.20, 103.10, 51.40, 57.70, 110.60, '2022-02-03 12:34:44'),
	(817, 'admin', 00005, '11', '12', 300.10, 300.00, 300.00, 300.00, 69.10, 56.30, 63.30, 145.20, 124.40, 51.40, 57.70, 110.60, '2022-02-03 12:34:36'),
	(818, 'admin', 00005, '10', '11', 111.10, 300.00, 300.00, 300.00, 69.10, 56.30, 63.30, 145.20, 124.40, 51.40, 57.70, 110.60, '2022-02-03 12:34:31'),
	(819, 'admin', 00005, '09', '10', 300.90, 300.00, 300.00, 300.00, 69.10, 56.30, 63.30, 145.20, 103.10, 51.40, 57.70, 110.60, '2022-02-03 12:34:26'),
	(820, 'admin', 00005, '08', '09', 300.80, 300.00, 300.00, 300.00, 69.10, 56.30, 63.30, 145.20, 63.00, 51.40, 57.70, 110.60, '2022-02-03 12:34:21'),
	(821, 'admin', 00005, '07', '08', 300.00, 344.40, 300.00, 300.00, 69.10, 56.30, 63.30, 145.20, 63.00, 51.40, 57.70, 110.60, '2022-02-03 12:34:13'),
	(822, 'admin', 00005, '06', '07', 300.00, 333.30, 300.00, 300.00, 69.10, 56.30, 63.30, 145.20, 63.00, 52.40, 58.70, 112.60, '2022-02-03 12:34:08'),
	(823, 'admin', 00005, '05', '06', 300.60, 322.20, 300.00, 300.00, 69.10, 56.30, 63.30, 145.20, 63.00, 51.40, 57.70, 110.60, '2022-02-03 12:34:01'),
	(824, 'admin', 00005, '04', '05', 300.50, 311.10, 300.00, 300.00, 69.10, 56.30, 63.30, 145.20, 63.00, 51.40, 57.70, 110.60, '2022-02-03 12:33:55'),
	(825, 'admin', 00005, '03', '04', 123.40, 300.00, 300.00, 300.00, 369.10, 56.30, 63.30, 145.20, 63.00, 51.40, 57.70, 110.60, '2022-02-03 12:33:44'),
	(826, 'admin', 00005, '02', '03', 300.30, 300.00, 300.00, 300.00, 469.10, 56.30, 63.30, 145.20, 63.00, 51.40, 57.70, 110.60, '2022-02-03 12:33:33'),
	(827, 'admin', 00005, '01', '02', 300.20, 311.00, 299.00, 289.10, 269.20, 156.30, 163.30, 145.20, 63.00, 51.40, 57.70, 110.60, '2022-02-03 12:33:22'),
	(828, 'admin', 00005, '00', '01', 310.10, 311.10, 300.00, 255.20, 169.10, 556.30, 123.40, 2145.20, 63.00, 51.40, 57.70, 110.60, '2022-02-03 12:33:08'),
	(829, 'local', 00005, '23', '24', 302.30, 312.30, 300.00, 300.00, 69.10, 56.30, 63.30, 145.20, 63.00, 51.40, 57.70, 901.10, '2022-02-04 18:00:13'),
	(830, 'local', 00005, '22', '23', 302.20, 300.00, 300.00, 300.00, 69.10, 56.30, 63.30, 145.20, 103.10, 51.40, 57.70, 110.60, '2022-02-03 12:35:52'),
	(831, 'local', 00005, '21', '22', 302.10, 300.00, 300.00, 300.00, 69.10, 56.30, 63.30, 145.20, 103.10, 51.40, 57.70, 110.60, '2022-02-03 12:35:47'),
	(832, 'local', 00005, '20', '21', 302.00, 300.00, 300.00, 300.00, 69.10, 56.30, 63.30, 145.20, 103.10, 51.40, 57.70, 110.60, '2022-02-03 12:35:41'),
	(833, 'local', 00005, '19', '20', 301.90, 300.00, 300.00, 300.00, 69.10, 56.30, 63.30, 145.20, 103.10, 51.40, 57.70, 110.60, '2022-02-03 12:35:37'),
	(834, 'local', 00005, '18', '19', 301.80, 300.00, 300.00, 300.00, 69.10, 56.30, 63.30, 145.20, 103.10, 51.40, 57.70, 110.60, '2022-02-03 12:35:32'),
	(835, 'local', 00005, '17', '18', 301.70, 300.00, 300.00, 300.00, 69.10, 66.30, 64.30, 143.20, 103.10, 52.40, 58.70, 113.60, '2022-02-03 12:35:28'),
	(836, 'local', 00005, '16', '17', 301.60, 300.00, 300.00, 300.00, 79.10, 56.30, 63.30, 145.20, 124.40, 51.40, 57.70, 110.60, '2022-02-03 12:35:22'),
	(837, 'local', 00005, '15', '16', 122.10, 300.00, 300.00, 300.00, 69.10, 56.30, 63.30, 145.20, 124.40, 51.40, 57.70, 110.60, '2022-02-03 12:35:17'),
	(838, 'local', 00005, '14', '15', 301.40, 300.00, 300.00, 300.00, 69.10, 56.30, 63.30, 145.20, 124.40, 51.40, 57.70, 110.60, '2022-02-03 12:35:10'),
	(839, 'local', 00005, '13', '14', 301.30, 300.00, 300.00, 300.00, 69.10, 56.30, 63.30, 145.20, 124.40, 51.40, 57.70, 110.60, '2022-02-03 12:35:01'),
	(840, 'local', 00005, '12', '13', 300.10, 300.00, 300.00, 300.00, 69.10, 56.30, 63.30, 145.20, 103.10, 51.40, 57.70, 110.60, '2022-02-03 12:34:44'),
	(841, 'local', 00005, '11', '12', 300.10, 300.00, 300.00, 300.00, 69.10, 56.30, 63.30, 145.20, 124.40, 51.40, 57.70, 110.60, '2022-02-03 12:34:36'),
	(842, 'local', 00005, '10', '11', 111.10, 300.00, 300.00, 300.00, 69.10, 56.30, 63.30, 145.20, 124.40, 51.40, 57.70, 110.60, '2022-02-03 12:34:31'),
	(843, 'local', 00005, '09', '10', 300.90, 300.00, 300.00, 300.00, 69.10, 56.30, 63.30, 145.20, 103.10, 51.40, 57.70, 110.60, '2022-02-03 12:34:26'),
	(844, 'local', 00005, '08', '09', 300.80, 300.00, 300.00, 300.00, 69.10, 56.30, 63.30, 145.20, 63.00, 51.40, 57.70, 110.60, '2022-02-03 12:34:21'),
	(845, 'local', 00005, '07', '08', 300.00, 344.40, 300.00, 300.00, 69.10, 56.30, 63.30, 145.20, 63.00, 51.40, 57.70, 110.60, '2022-02-03 12:34:13'),
	(846, 'local', 00005, '06', '07', 300.00, 333.30, 300.00, 300.00, 69.10, 56.30, 63.30, 145.20, 63.00, 52.40, 58.70, 112.60, '2022-02-03 12:34:08'),
	(847, 'local', 00005, '05', '06', 300.60, 322.20, 300.00, 300.00, 69.10, 56.30, 63.30, 145.20, 63.00, 51.40, 57.70, 110.60, '2022-02-03 12:34:01'),
	(848, 'local', 00005, '04', '05', 300.50, 311.10, 300.00, 300.00, 69.10, 56.30, 63.30, 145.20, 63.00, 51.40, 57.70, 110.60, '2022-02-03 12:33:55'),
	(849, 'local', 00005, '03', '04', 123.40, 300.00, 300.00, 300.00, 369.10, 56.30, 63.30, 145.20, 63.00, 51.40, 57.70, 110.60, '2022-02-03 12:33:44'),
	(850, 'local', 00005, '02', '03', 300.30, 300.00, 300.00, 300.00, 469.10, 56.30, 63.30, 145.20, 63.00, 51.40, 57.70, 110.60, '2022-02-03 12:33:33'),
	(851, 'local', 00005, '01', '02', 300.20, 311.00, 299.00, 289.10, 269.20, 156.30, 163.30, 145.20, 63.00, 51.40, 57.70, 110.60, '2022-02-03 12:33:22'),
	(852, 'local', 00005, '00', '01', 310.10, 311.10, 300.00, 255.20, 169.10, 556.30, 123.40, 2145.20, 63.00, 51.40, 57.70, 110.60, '2022-02-03 12:33:08');
/*!40000 ALTER TABLE `tUnitPriceInfo` ENABLE KEYS */;

-- 테이블 HelloCharger.tUserInfo 구조 내보내기
CREATE TABLE IF NOT EXISTS `tUserInfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_login_type` varchar(10) NOT NULL,
  `user_naver_id` varchar(20) DEFAULT NULL,
  `user_email` varchar(30) NOT NULL,
  `user_password` varchar(32) DEFAULT NULL,
  `user_nickname` varchar(20) DEFAULT NULL,
  `user_card_number` varchar(16) DEFAULT NULL,
  `user_card_stop` varchar(1) NOT NULL DEFAULT 'N' COMMENT '회원카드정지여부, N:정지, Y:사용',
  `user_kind` varchar(6) DEFAULT '과금' COMMENT '회원 구분 (과금, 무과금)',
  `naver_user_accessToken` varchar(100) DEFAULT NULL,
  `naver_user_refreshToken` varchar(150) DEFAULT NULL,
  `naver_user_expiresAt` varchar(16) DEFAULT NULL,
  `naver_user_tokenType` varchar(10) DEFAULT NULL,
  `status` tinyint(1) DEFAULT 1 COMMENT '1:login, 2:logout',
  `member_id` varchar(12) DEFAULT NULL,
  `updateTime` timestamp NOT NULL DEFAULT (current_timestamp() + interval 9 hour) COMMENT '등록일시',
  `delete_status` varchar(10) NOT NULL DEFAULT '정상' COMMENT '삭제여부: 정상인 경우 "정상", 삭제된 경우 "삭제" ',
  `delete_time` timestamp NULL DEFAULT NULL COMMENT '삭제된 시각',
  PRIMARY KEY (`id`),
  KEY `uUserInfo_idx1` (`user_naver_id`,`user_email`),
  KEY `user_card_number` (`user_card_number`)
) ENGINE=InnoDB AUTO_INCREMENT=316 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='헬로우차저 사용자 정보';

-- 테이블 데이터 HelloCharger.tUserInfo:~0 rows (대략적) 내보내기
DELETE FROM `tUserInfo`;
/*!40000 ALTER TABLE `tUserInfo` DISABLE KEYS */;
/*!40000 ALTER TABLE `tUserInfo` ENABLE KEYS */;

-- 테이블 HelloCharger.tUserWithdraw 구조 내보내기
CREATE TABLE IF NOT EXISTS `tUserWithdraw` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_login_type` varchar(10) NOT NULL,
  `user_naver_id` varchar(20) DEFAULT NULL,
  `user_email` varchar(30) NOT NULL,
  `user_password` varchar(32) DEFAULT NULL,
  `user_nickname` varchar(20) DEFAULT NULL,
  `naver_user_accessToken` varchar(100) DEFAULT NULL,
  `naver_user_refreshToken` varchar(150) DEFAULT NULL,
  `naver_user_expiresAt` varchar(16) DEFAULT NULL,
  `naver_user_tokenType` varchar(10) DEFAULT NULL,
  `status` tinyint(1) DEFAULT 1,
  `updateTime` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `uUserWithdraw_idx1` (`user_naver_id`,`user_email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 HelloCharger.tUserWithdraw:~0 rows (대략적) 내보내기
DELETE FROM `tUserWithdraw`;
/*!40000 ALTER TABLE `tUserWithdraw` DISABLE KEYS */;
/*!40000 ALTER TABLE `tUserWithdraw` ENABLE KEYS */;

-- 테이블 HelloCharger.tWithdrawReason 구조 내보내기
CREATE TABLE IF NOT EXISTS `tWithdrawReason` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_email` varchar(30) NOT NULL,
  `withdraw_reason` varchar(50) DEFAULT NULL,
  `withdraw_memo` varchar(200) DEFAULT NULL,
  `updateTime` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 HelloCharger.tWithdrawReason:~0 rows (대략적) 내보내기
DELETE FROM `tWithdrawReason`;
/*!40000 ALTER TABLE `tWithdrawReason` DISABLE KEYS */;
/*!40000 ALTER TABLE `tWithdrawReason` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;





-- --------------------------------------------------------
-- 호스트:                          127.0.0.1
-- 서버 버전:                        10.6.21-MariaDB-ubu2004 - mariadb.org binary distribution
-- 서버 OS:                        debian-linux-gnu
-- HeidiSQL 버전:                  11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- HelloCharger_ErrorReporter 데이터베이스 구조 내보내기
CREATE DATABASE IF NOT EXISTS `HelloCharger_ErrorReporter` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `HelloCharger_ErrorReporter`;

-- 테이블 HelloCharger_ErrorReporter.tErrorReport 구조 내보내기
CREATE TABLE IF NOT EXISTS `tErrorReport` (
  `seqno` int(11) NOT NULL AUTO_INCREMENT,
  `component` varchar(20) DEFAULT '',
  `element` varchar(40) NOT NULL DEFAULT '',
  `errorMsg` varchar(200) DEFAULT '',
  `occurTime` timestamp NULL DEFAULT NULL,
  `updateTime` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`seqno`,`element`) USING BTREE,
  KEY `element` (`element`,`errorMsg`,`occurTime`)
) ENGINE=InnoDB AUTO_INCREMENT=39446620 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- 테이블 데이터 HelloCharger_ErrorReporter.tErrorReport:~0 rows (대략적) 내보내기
DELETE FROM `tErrorReport`;
/*!40000 ALTER TABLE `tErrorReport` DISABLE KEYS */;
INSERT INTO `tErrorReport` (`seqno`, `component`, `element`, `errorMsg`, `occurTime`, `updateTime`) VALUES
	(39446619, 'EVC_OCPP', '{backend}/station/isExistSerialNumber', 'AppError - invalid json response body at http://3.36.30.180:3002/ocpp/statusNotification reason: Unexpected token < in JSON at position 0', NULL, '2025-05-08 02:44:38');
/*!40000 ALTER TABLE `tErrorReport` ENABLE KEYS */;

-- 테이블 HelloCharger_ErrorReporter.tErrorReport2 구조 내보내기
CREATE TABLE IF NOT EXISTS `tErrorReport2` (
  `seqno` int(11) NOT NULL AUTO_INCREMENT,
  `component` varchar(20) DEFAULT '',
  `element` varchar(40) NOT NULL DEFAULT '',
  `errorMsg` varchar(200) DEFAULT '',
  `occurTime` timestamp NULL DEFAULT NULL,
  `updateTime` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`seqno`,`element`) USING BTREE,
  KEY `element` (`element`,`errorMsg`,`occurTime`)
) ENGINE=InnoDB AUTO_INCREMENT=36960828 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- 테이블 데이터 HelloCharger_ErrorReporter.tErrorReport2:~0 rows (대략적) 내보내기
DELETE FROM `tErrorReport2`;
/*!40000 ALTER TABLE `tErrorReport2` DISABLE KEYS */;
/*!40000 ALTER TABLE `tErrorReport2` ENABLE KEYS */;

USE `HelloCharger`;

-- 테이블 HelloCharger.daily_values 구조 내보내기 (대시보드 일별 충전통계)
CREATE TABLE IF NOT EXISTS `daily_values` (
  `id` varchar(36) NOT NULL,
  `member_id` varchar(12) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `cnt` int(11) DEFAULT 0,
  `pow` bigint(20) DEFAULT 0,
  `mon` bigint(20) DEFAULT 0,
  `created_at` date DEFAULT NULL,
  `updated_at` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_member_date` (`member_id`,`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='일별 충전통계 (updateDailyData cron)';

-- 테이블 HelloCharger.monthly_values 구조 내보내기 (대시보드 월별 충전통계)
CREATE TABLE IF NOT EXISTS `monthly_values` (
  `id` varchar(36) NOT NULL,
  `member_id` varchar(12) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `cnt` int(11) DEFAULT 0,
  `pow` bigint(20) DEFAULT 0,
  `mon` bigint(20) DEFAULT 0,
  `created_at` date DEFAULT NULL,
  `updated_at` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_member_date` (`member_id`,`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='월별 충전통계 (updateMonthlyData cron)';

-- 테이블 HelloCharger.tENVRegiChargeHistoryLog 구조 내보내기 (환경부 재등록 이력 로그)
CREATE TABLE IF NOT EXISTS `tENVRegiChargeHistoryLog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `from_date` datetime DEFAULT NULL,
  `total` int(11) DEFAULT 0,
  `sent` int(11) DEFAULT 0,
  `skip` int(11) DEFAULT 0,
  `error` int(11) DEFAULT 0,
  `error_detail` text DEFAULT NULL,
  `trigger_type` varchar(10) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='환경부 충전이력 재등록 실행 로그';

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
