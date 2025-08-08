//
//  TrainingPlanDTO.swift
//  Gliding
//
//  Created by 안정흠 on 7/25/25.
//

import Foundation
import SwiftData
//trn_plan_no    numeric(7)    훈련표 번호    PK
//member_no    numeric(6)    회원번호    FK
//share_yn    varchar(1)    공유 여부    NOT NULL
//default ‘N’
//trn_category    char(2)    훈련 카테고리(TR002)    NOT NULL
//default ‘99’
//trn_plan_title    varchar(50)    훈련표 제목    NOT NULL
//trn_plan_conts    varchar(200)    훈련표 상세 내용
//trn_plan_sets    json    훈련표 Set 정보    NOT NULL
//trn_plan_like_cnt    numeric(7)    훈련표 좋아요 개수    NOT NULL
//default 0
//trn_plan_reply_cnt    numeric(7)    훈련표 댓글 개수    NOT NULL
//default 0
//reg_dtm    timestamp    등록일자    NOT NULL
//mod_dtm    timestamp    수정일자    NOT NULL

@Model
final class TrainingPlanDTO {
    var trn_plan_no: Int
    var member_no: Int
    var share_yn: String // character 타입은 안되나?
    var trn_category: String
    var trn_plan_title: String
    var trn_plan_conts: String
//    var trn_plan_sets    //json
    var reg_dtm: Date
    var mod_dtm: Date
    
    
    
    
    
    init(trn_plan_no: Int, member_no: Int, share_yn: String, trn_category: String, trn_plan_title: String, trn_plan_conts: String, reg_dtm: Date, mod_dtm: Date) {
        self.trn_plan_no = trn_plan_no
        self.member_no = member_no
        self.share_yn = share_yn
        self.trn_category = trn_category
        self.trn_plan_title = trn_plan_title
        self.trn_plan_conts = trn_plan_conts
        self.reg_dtm = reg_dtm
        self.mod_dtm = mod_dtm
    }
    
    
}
