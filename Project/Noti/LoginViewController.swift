//
//  ViewController.swift
//  Noti
//
//  Created by 이채원 on 2016. 10. 19..
//  Copyright © 2016년 이채원. All rights reserved.
//

import UIKit
import Firebase
import Reductio

class LoginViewController: UIViewController {
    
    //var ref: Firebase?
    @IBOutlet var IDTextField: UITextField!
    @IBOutlet var PWTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var ref = FIRDatabase.database().reference()
        
        //ref.child("no").child("assr").setValue(["username": "fuck"])
        
        // Do any additional setup after loading the view, typically from a nib.
        
        //let text = "제 3회 한양대학교 프로그래밍 경시대회는 한양대학교 컴퓨터공학부에서 한양대학교 모든 학생을 대상으로 주최하는 프로그래밍 대회입니다. 본 대회는 학생들의 논리적 사고능력으로 프로그래밍 문제를 해결하는 것을 목적으로 하고 있습니다.전공 부문인 Advanced Division과 비전공자 부문인 Beginner Division으로 나누어서 대회를 진행하기 때문에 비전공자들도 도전해볼 수 있고 대부분 알고리즘에 대해 배우지 않아도 해결할 수 있는 문제들이 출제된다고 하니 부담 없이 참가하셔도 좋을 거 같습니다.자세한 사항은 대회 공식 홈페이지 hcpc.hanyang.ac.kr을 참고해주세요."
        let text = "이번 겨울 방학에도 어김없이 찾아온 어학 프로그램입니다~! 예전과는 다르게 이번 어학 프로그램에는 TEPS수업도 포함되어있다고 합니다. 레벨 테스트를 통해 영어회화반 2개 분반으로 진행하며 TEPS수업은 2개반 합반으로 진행합니다. 기간은 1/2(월) ~ 1/20(금)으로 주 5일 하루 4시간 진행합니다.(주중에만!) 주 5일중 2-3일은 영어회화 수업, 나머지 2-3일은 TE/PS수업을 한다고 하네요. 아직 공고안이 나오지 않았지만 혹시 방학때 일정을 잡아서 참여를 못하는 학생이 있을까봐 어학 프로그램에 대해 지금까지 나온 계획안을 먼저 공고해드립니다! (TEPS에 관심있는 학생들은 이번에 들으시면 좋을거 같아요~)"
        //let text = "여러분 저도 잊고 있었던.. 내일은 바로 제 6회 TOPCIT 정기평가가 있는날입니다! 오전 9시 반부터 IT/BT 607호에서 진행되니 TOPCIT 신청자분들께서는 늦지않게 와주세요!"
        //let text = "안녕하세요 학생회장 원상혁입니다! 저번에 공지해드렸던 SK하이닉스 산학장학생 모집 공고가 오늘 중으로 소프트웨어전공 홈페이지에 올라온다고 합니다. 지원서 제출 기한이 다음주 월요일 오전이니 늦지 않게 지원해주세요~~"
        //let text = "존경하는 소프트웨어전공 자치회에서 중간고사에 지친 학우여러분들을위해 야식 배부 사업을 진행하고자 합니다! 이번 야식은 큐카페의 '아메리카노(ice / hot) + 머핀 세트'를 준비했습니다! 목,금 1-6시에 로비에서 쿠폰을 배부할 예정이니 야식을 드실 분들은 정해진 시간에 학생증을 가지고 와주세요! 쿠폰 사용방법 1. 정해진 시간[이번주 목,금 오후 1-6시]에 학생증을 가지고 로비에서 쿠폰을 배부받는다. 2. 10/24(월) - 10/28(금) 사이에 원하는 시간에 큐카페에서 쿠폰을 내고 야식을 받는다. 3. 아메리카노는 ice, hot을 선택할 수 있으며, 머핀도 초코, 블루베리, 치즈 세가지 맛중 한개를 선택할 수 있습니다. 4. 쿠폰에 적혀있는 선택지는 본인이 체크할 필요없습니다!! (큐카페에서 체크해주신다고 합니다!)"
        //let text = "자동차-SW 융합전공 안내 21세기 4차 산업혁명을 주도할 자동차-SW 융합형 교육 프로그램에 참여할 학부생들을 모집합니다. (1) 융합전공 소개 - 전공명칭: 자동차-SW 융합전공 (국문) Major in Automotive-Computer Convergence Engineering (영문) - 관장학과: 소프트웨어융합원 - 수여학위명: 공학사 (국문), Bachelor of Science (B.S) (영문) - 이수기준: 융합전공 36학점 이상(전공핵심 21학점, 전공심화 6학점 포함), 부전공 21학점 이상(전공핵심 12학점 포함) - 융합전공 교과목: O  SW 영역: 자료구조, 알고리즘, 운영체제, 데이터베이스, 인공지능 O 자동차영역: 동역학, CAD, 전자기학, 마이크로프로세서응용, 시스템해석, 자동제어, 차량센서 O  융합영역: 지능제어SW, 차량임베디드시스템 ※ 융합전공 이수를 위한 교과목 중 자동차영역은 지정 7개 중 5개 과목 선택 수강 (2) 신청 및 선발 - 신청 기간: 2016.12.01.(목)~12.08(목) 17:00까지 - 신청 대상: 1개 정규학기 이상의 유효한 성적이 있는 재학생. 학부 성적 제한 없음 - 신청 방법: 한양 포털 HY-in “전공신청”에서 신청 (3) 문의사항  - 전화 문의: 02-2220-2273 / 02-2220-2386 - 이메일 문의: possibleguy@hanyang.ac.kr / eg1224@hanyang.ac.kr - 방문 문의: 공업센터 본관 503호"
        //let text = "다름이 아니라 올해 SK하이닉스 산학 장학생 모집에 관해서 알려드릴려고 합니다. 대상 : 소프트웨어 전공 2,3학년일정 : 1. 10/31(월) 지원서 제출 마감 2. 11/4(금) 서류 전형 발표 3. 11/16(수) 인적성 검사(학교 내 실시) 4. 11/25(금) 면접 5. 11/30(수) 합격자 발표 기타 : 지원자 제한 없음, 4학년은 대상 미정 산학장학생으로 선정될 좋은 기회입니다!! 자세한 사항은 소프트웨어전공 홈페이지( http://cs.hanyang.ac.kr/software ) 에 게시될 예정입니다. 담당자 출장중이라 지원서 포맷은 다음주중으로 올라온다고 하니 지원서 올라오면 한번 더 공지하도록 하겠습니다."
        //let text = "다시한번 공지드려 죄송하지만! 제대로 공지해드릴게요!! 투표 일정 : 22일(화) ~ 24일(목) 매일 9시 ~ 19시 투표 장소 : IT/BT 3층 로비(투표소 보임) 선거 방법 : 학생증을 준비한 후 간단하게 신원조사 후 총학생회, 공과대학학생회, 컴퓨터공학부 학생회 투표를 하시면됩니다! (자신이 원하는 단체에만 투표해도 됩니다. 컴공에만 하셔도되고 총학생회만 빼고 하셔도되고 상관은 없습니다! 다만 다해주시면 서로 서로 좋을것 같아요~) 투표는 2016년도 2학기 재학생이어야만 가능하니 이점 확인해주시고 학생증이 없으면 신분을 증명할 수 있는 것으로도 가능합니다~~"
        
        Reductio.keywords(from: text, count: 20) { words in
            //print(words)
            
            print(Reductio.keyPhrase(word:words[0]))
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func login(_ sender: AnyObject) {
        
        /*
        FIRAuth.auth()?.signInAnonymously(completion:{ (user, error) in // 2
            if let err = error { // 3
                //print(err.localizedDescription)
                print("***********************")
                return
            }
            
            //self.performSegue(withIdentifier: "LoginToChat", sender: nil) // 4
        })*/
        
        FIRAuth.auth()?.signIn(withEmail: IDTextField.text!, password: PWTextField.text!, completion: {(user,error) in
            
            if let err = error { // 3
                //print(err.localizedDescription)
                print("***********************")
                return
            }
            
            let toVC = self.storyboard?.instantiateViewController(withIdentifier: "NotiTabbarController")
            
            self.present(toVC!, animated: true, completion: nil)
        })
    }
    
}

