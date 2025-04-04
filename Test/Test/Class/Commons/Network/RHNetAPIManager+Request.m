//
//  RHNetAPIManager+Request.m
//  JieBao
//
//  Created by 孙若淮 on 25/10/2017.
//  Copyright © 2017 Monster. All rights reserved.
//

#import "RHNetAPIManager+Request.h"

@implementation RHNetAPIManager (Request)
#pragma mark - 启动页

/**
 引导页和启动页
 
 @return <#return value description#>
 */
-(RHNetAPIManager*)appStartPageOPT {
    
    self.aPath = @"";
    return self;
}

#pragma mark - 登录

/**
 登录
 
 @param params data:{
 "phone":"1",//账号(必)
 "pwd":"123456abc",//密码(必)
 "type":"0"//登录类型(0:求职者端,1:企业端)(必)
 }
 @return <#return value description#>
 */
-(RHNetAPIManager*)appLoginOPT:(NSMutableDictionary *)params {
    
    self.aPath = @"/app/user/login.do";
    [self.params setValuesForKeysWithDictionary:params];
    return self;
}

#pragma mark 退出登录

/**
 退出登录
 
 @param params token//必填
 @return <#return value description#>
 */
-(RHNetAPIManager*)appLoginOutOPT:(NSMutableDictionary *)params {
    
    self.aPath = @"/app/user/loginOut.do";
    [self.params setValuesForKeysWithDictionary:params];
    return self;
}

#pragma mark 闪验登录
/**
 闪验登录
 
 @param params {
 "appId":"4Mo0CUxW",//当前APP对应的appid
 "accessToken":"39482ab998a9434da59149ba327873db",//运营商token
 "telecom":"CTCC",//运营商
 "timestamp":"1542616537000",//UNIX时间戳，毫秒级
 "randoms":"11fbc1e0a450498eaa41737de2fd12ea",//随机数
 "sign":"AeV4+i3r5al\/fBxXvzXL9EgEQCY=",//签名
 "version":"2.0.3",//SDK版本号
 "device":"HUAWEI",//设备型号
 "type":"0"//0求职端,1企业端
 }
 @return <#return value description#>
 */
-(RHNetAPIManager*)appSYLoginOPT:(NSMutableDictionary *)params{
    self.aPath = @"/app/syLogin.do";
    [self.params setValuesForKeysWithDictionary:params];
    return self;
}

#pragma mark 第三方登录
/**
 第三方登录
 
 @param params data:{
 "openId":"o3iNa1J_O5z8LSouJuiVrMGjyvlY",//第三方登录用户的id
 "status":"3",//登录标识,1:微博登录,2:qq登录,3:微信登录
 "type":"0"//0求职端,1企业端
 }
 @return <#return value description#>
 */
-(RHNetAPIManager*)appThirdLoginWithOPT:(NSMutableDictionary *)params{
    self.aPath = @"/app/thirdLogin.do";
    [self.params setValuesForKeysWithDictionary:params];
    return self;
}

#pragma mark 第三方登录用户绑定
/**
 第三方登录用户绑定
 
 @param params data:{
 "phone":"13632386076",//手机号
 "code":"373581",//验证码
 "type":"0",//0求职者端,1:企业端
 "oppenId":"SADDS1234",//第三方用户标识id
 "headimgurl":"http://183.60.229.149/group1/M00/00/0A/tzzllVvNb_2ADb-jAAC3I-0XRvc929.JPG",//第三方用户头像
 "nickname":"李思",//第三方用户昵称
 "status":"1"//登录标识,1:微博登录,2:qq登录,3:微信登录
 }
 @return <#return value description#>
 */
-(RHNetAPIManager*)appThirdBindingOPT:(NSMutableDictionary *)params{
    self.aPath = @"/app/thridBinding.do";
    [self.params setValuesForKeysWithDictionary:params];
    return self;
}

#pragma mark 获取验证码
/**
 获取验证码

 @param params data:{"phone":"15800000012"//电话号码(必填)}
 @return <#return value description#>
 */
-(RHNetAPIManager*)appGetSmsCodeOPT:(NSMutableDictionary *)params {
    
    self.aPath = @"/app/user/getSmsCode.do";
    [self.params setValuesForKeysWithDictionary:params];
    return self;
}

#pragma mark 注册
/**
 注册
 
 @param params data{
 "phone":"13632386061",//账号(必)
 "pwd":"123456abc",密码(必)
 "code":"1234",//验证码(必)
 }
 @return <#return value description#>
 */
-(RHNetAPIManager*)appRegisiterOPT:(NSMutableDictionary *)params {
    
    self.aPath = @"/app/user/register.do";
    [self.params setValuesForKeysWithDictionary:params];
    return self;
}

#pragma mark 忘记密码
/**
 忘记密码

 @param params data:{
 "phone":"13632386061",//账号(必)
 "code":"1234",//验证码(必)
 "pwd":"123456abc"//密码(必)
 }
 @return <#return value description#>
 */
-(RHNetAPIManager*)appResetPwdOPT:(NSMutableDictionary *)params {
    
    self.aPath = @"/app/user/resetPwd.do";
    [self.params setValuesForKeysWithDictionary:params];
    return self;
}
#pragma mark 根据手机号查询头像
/**
 根据手机号查询头像
 
 @param params data:{"phone":"15800000001"}//手机号(必)
 @return <#return value description#>
 */
-(RHNetAPIManager*)appGetHeadPicByPhoneOPT:(NSMutableDictionary *)params {
    
    self.aPath = @"/app/user/getHeadPicByPhone.do";
    [self.params setValuesForKeysWithDictionary:params];
    return self;
}

#pragma mark 修改绑定账号
/**
 修改绑定账号
 
 @param params token(必)
 data:{
 "phone":"15800000018",//新手机号
 "code":"081641"//验证码
 }
 }
 @return <#return value description#>
 */
-(RHNetAPIManager*)appChangePhoneOPT:(NSMutableDictionary *)params {
    
    self.aPath = @"/app/user/changePhone.do";
    [self.params setValuesForKeysWithDictionary:params];
    return self;
}

#pragma mark 个人中心--设置初始化（接口）
/**
 个人中心--设置初始化（接口）
 
 @param params token(必)
 
 @return <#return value description#>
 */
-(RHNetAPIManager*)appSettingInitCopyOPT:(NSMutableDictionary *)params {
    
    self.aPath = @"/app/appSettingInitCopy.do";
    [self.params setValuesForKeysWithDictionary:params];
    return self;
}
#pragma mark - 求职端
#pragma mark - 首页

#pragma mark 求职端首页
/**
 求职端首页
 
 @param params token(选,不填不会返回是否需要完善信息字段)
 @return <#return value description#>
 */
-(RHNetAPIManager*)appUserIndexOPT:(NSMutableDictionary *)params {
    
    self.aPath = @"/app/user/userIndex.do";
    [self.params setValuesForKeysWithDictionary:params];
    return self;
}
#pragma mark 职位搜索
/**
 职位搜索
 
 @param params  token    string    是
                data    string    是
                page    string    是
 data{
 "type":"0",//0:全部职位,1:附近职位,2:高薪职位(必填,app传0就可以了)
 "industryClassId":"1",行业类别(选)不限不传
 "workYear":"1",//工作经验(选)(全部不传,0,应届生 1.3年以下 2.3-5年 3.5-10年,4.10年以上)
 "salaryRangeId":"1",//薪资范围(全部不传)(选)
 "workAddressRegionId":"1",//就职区域id(选)
 "jobName",//岗位名称(选)
 "educationLevel":"1"//学历(选)(全部不传,1大专,2本科,3研究生,4博士)
 }
 @return <#return value description#>
 */
-(RHNetAPIManager*)appPostsSearchOPT:(NSMutableDictionary *)params {
    
    self.aPath = @"/app/post/postsSearch.do";
    [self.params setValuesForKeysWithDictionary:params];
    return self;
}
#pragma mark 获取求职端热门搜索
/**
 获取求职端热门搜索
 
 @return <#return value description#>
 */
-(RHNetAPIManager*)appGetUserHotSearchOPT{
    
    self.aPath = @"/app/post/getUserHotSearch.do";
    return self;
}
#pragma mark 职位详情(完成,求职端,企业端共用)
/**
 职位详情(完成,求职端,企业端共用)
 
 @param params token(选,不填没有是否点赞的信息,是否收藏,是否投递的信息)
 data:{
 "postId":"28"//职位id(必)
 "companyId":"3"//公司id(必)
 }
 @return <#return value description#>
 */
-(RHNetAPIManager*)appToPostDetailsOPT:(NSMutableDictionary *)params {
    
    self.aPath = @"/app/post/toPostDetails.do";
    [self.params setValuesForKeysWithDictionary:params];
    return self;
}

#pragma mark 查询岗位全部评论
/**
 查询岗位全部评论
 
 @param params token:(选,不填没有是否点赞信息)
 data:{
 "postId":"4"(职位详情页评论必填)
 "companyId"(公司详情页评论必填)
 }
 page:
 {
 "currPage":当前页,(必)
 "pageSize":一页几条(必)
 }
 @return <#return value description#>
 */
-(RHNetAPIManager*)appUserFindCommentListOPT:(NSMutableDictionary *)params {
    
    self.aPath = @"/app/post/userFindCommentList.do";
    [self.params setValuesForKeysWithDictionary:params];
    return self;
}

#pragma mark 求职端评论点赞和取消点赞
/**
 求职端评论点赞和取消点赞
 
 @param params ttoken(必填)
 data:{
 "commentId":"13",//评论id
 "type":"1"//type = 1 点赞  type = 0 取消点赞
 }
 @return <#return value description#>
 */
-(RHNetAPIManager*)appUserGoodCountOPT:(NSMutableDictionary *)params {
    
    self.aPath = @"/app/post/userGoodCount.do";
    [self.params setValuesForKeysWithDictionary:params];
    return self;
}

#pragma mark 求职端职位收藏
/**
 求职端职位收藏
 
 @param params token(必)
 data:{"postId":"20',}  postId 职位id
 @return <#return value description#>
 */
-(RHNetAPIManager*)appPostCollectOPT:(NSMutableDictionary *)params {
    
    self.aPath = @"/app/job/postCollect.do";
    [self.params setValuesForKeysWithDictionary:params];
    return self;
}
#pragma mark 求职端取消职位收藏
/**
 求职端取消职位收藏
 
 @param params token(必)
 data:{"postId":"20',}  postId 职位id
 @return <#return value description#>
 */
-(RHNetAPIManager*)appDeletePostCollectOPT:(NSMutableDictionary *)params {
    
    self.aPath = @"/app/job/deletePostCollect.do";
    [self.params setValuesForKeysWithDictionary:params];
    return self;
}

#pragma mark 求职端投递简历
/**
 求职端投递简历
 
 @param params token(必)
 {"postId":"20',"resumeType":"0"}  postId 职位id resumeType 简历类型 0 在线 1 附件 
 @return <#return value description#>
 */
-(RHNetAPIManager*)appSendResumeOPT:(NSMutableDictionary *)params {
    
    self.aPath = @"/app/cjUserMetting/sendResume.do";
    [self.params setValuesForKeysWithDictionary:params];
    return self;
}

#pragma mark 求职端公司详情
/**
 求职端公司详情
 
 @param params token(必)
 data:{"companyId":"3"}//公司id
 @return <#return value description#>
 */
-(RHNetAPIManager*)appToJumpUserCompanyDetailOPT:(NSMutableDictionary *)params {
    
    self.aPath = @"/app/mobile/toJumpUserCompanyDetail.do";
    [self.params setValuesForKeysWithDictionary:params];
    return self;
}

#pragma mark 查询公司在招职位
/**
 查询公司在招职位
 
 @param params data:{"companyId":"3"}//公司id(必)
 page {"currPage":1,"pageSize":10} currPage 页码数  pageSize 一页显示多少条
 @return <#return value description#>
 */
-(RHNetAPIManager*)appUserFindPostListOPT:(NSMutableDictionary *)params {
    
    self.aPath = @"/app/post/userFindPostList.do";
    [self.params setValuesForKeysWithDictionary:params];
    return self;
}

#pragma mark 关注/取消关注企业
/**
 关注/取消关注企业
 
 @param params token:(必填)
 data:{
 "companyId":"3",//公司id
 "type":"0"//0:取消关注,1:关注
 }
 @return <#return value description#>
 */
-(RHNetAPIManager*)appUserFollowOPT:(NSMutableDictionary *)params {
    
    self.aPath = @"/app/post/userFollow.do";
    [self.params setValuesForKeysWithDictionary:params];
    return self;
}

#pragma mark 查询企业工商信息
/**
 查询企业工商信息
 
 @param params data:{"companyName":"英迈思"}//必填
 @return <#return value description#>
 */
-(RHNetAPIManager*)appIndustryInfoOPT:(NSMutableDictionary *)params {
    
    self.aPath = @"/app/post/industryInfo.do";
    [self.params setValuesForKeysWithDictionary:params];
    return self;
}
#pragma mark - 消息 -------------------------
#pragma mark 消息-系统消息
/**
 消息-系统消息
 
 @param params token(必)
 page:{"currPage":1,"pageSize":10}(必)
 @return <#return value description#>
 */
-(RHNetAPIManager*)appSystemStationNewsOPT:(NSMutableDictionary *)params {
    
    self.aPath = @"/app/stationNews/systemStationNews.do";
    [self.params setValuesForKeysWithDictionary:params];
    return self;
}

#pragma mark 即使通讯头部信息
/**
 即使通讯头部信息
 
 @param params token(必)
 data{
 "otherUserId":"4",(必)//对方用户id
 "resumeId":"42",//简历id(选)
 "postId":"71"//职位id(选)
 }
 @return <#return value description#>
 */
-(RHNetAPIManager*)appGetImPageInfoOPT:(NSMutableDictionary *)params {
    
    self.aPath = @"/app/user/getImPageInfo.do";
    [self.params setValuesForKeysWithDictionary:params];
    return self;
}

#pragma mark 改变系统消息状态(已读,删除)
/**
 即使通讯头部信息
 
 @param params token(必)
 data{
 "type":1,(0:标为已读,1删除)
 "id":"967",消息id
 }
 @return <#return value description#>
 */
-(RHNetAPIManager*)appUpdateMsgOPT:(NSMutableDictionary *)params {
    
    self.aPath = @"/app/stationNews/updateMsg.do";
    [self.params setValuesForKeysWithDictionary:params];
    return self;
}

#pragma mark - 发现 -------------------------
#pragma mark 调起百度地图规划当前位置到终点的路线
/**
 调起百度地图规划当前位置到终点的路线
 
 @param params data:{
 "lat":"22.57179950083854",//纬度(必)
 "lng":"113.91941494199959",//经度(必)
 "companyAddress":"深圳北"//公司地址(必)
 }
 @return <#return value description#>
 */
-(RHNetAPIManager*)appGetBaiduMapUrlOPT:(NSMutableDictionary *)params {
    
    self.aPath = @"/app/post/getBaiduMapUrl.do";
    [self.params setValuesForKeysWithDictionary:params];
    return self;
}

#pragma mark - 个人 -------------------------
#pragma mark 基本信息初始化
/**
 基本信息初始化
 
 @param params token(必填)
 @return <#return value description#>
 */
-(RHNetAPIManager*)appResumeUserInfoOPT:(NSMutableDictionary *)params {
    
    self.aPath = @"/app/user/resumeUserInfo.do";
    [self.params setValuesForKeysWithDictionary:params];
    return self;
}

#pragma mark 简历列表页
/**
 简历列表页
 
 @param params token(必)
 page:{"currPage":1,"pageSize":10}
 @return <#return value description#>
 */
-(RHNetAPIManager*)appToJumpMyResumeOPT:(NSMutableDictionary *)params {
    
    self.aPath = @"/app/toJumpMyResume.do";
    [self.params setValuesForKeysWithDictionary:params];
    return self;
}
#pragma mark 求职端设置默认简历和附件简历
/**
 求职端设置默认简历和附件简历
 
 @param params token(必)
 data {“resumeType”:"0","open_type":"0","resumeId":"55"} resumeType 简历类型 0,在线简历 1.附件简历  open_type  1 默认  0 取消  resumeId 简历id
 @return <#return value description#>
 */
-(RHNetAPIManager*)appSetDefResumeOPT:(NSMutableDictionary *)params {
    
    self.aPath = @"/app/setDefResume.do";
    [self.params setValuesForKeysWithDictionary:params];
    return self;
}

#pragma mark 求职端简历公开程度
/**
 求职端简历公开程度
 
 @param params token(必)
 data:{"resumeId":"19","open_type":"0"}// resumeId 简历id  open_type (0.公开 1.保密)
 @return <#return value description#>
 */
-(RHNetAPIManager*)appSetOpenTypeOPT:(NSMutableDictionary *)params {
    
    self.aPath = @"/app/setOpenType.do";
    [self.params setValuesForKeysWithDictionary:params];
    return self;
}
#pragma mark 求职端简历删除
/**
 求职端简历删除
 
 @param params token(必)
 data:{"resumeId":"19"} 简历id
 @return <#return value description#>
 */
-(RHNetAPIManager*)appDeleteResumeByIdOPT:(NSMutableDictionary *)params {
    
    self.aPath = @"/app/deleteResumeById.do";
    [self.params setValuesForKeysWithDictionary:params];
    return self;
}

#pragma mark 新增/编辑简历初始化数据
/**
 新增/编辑简历初始化数据
 
 @param params token:(必)
 data:{"resumeId":"12"}//新增简历不填,编辑简历必填
 @return <#return value description#>
 */
-(RHNetAPIManager*)appToAddOrEditResumeOPT:(NSMutableDictionary *)params {
    
    self.aPath = @"/app/toAddOrEditResume.do";
    [self.params setValuesForKeysWithDictionary:params];
    return self;
}

#pragma mark 新增编辑简历求职意向
/**
 新增编辑简历求职意向
 
 @param params token(必)
 data:{
 "id":"46",//简历id(新增不填,编辑必填)
 "wantSalary":"1000",//期望薪资
 "positionLocationId":"411527",//地点id
 "workJob":"1",//职能
 "workPosition":"1",//职位
 "workClassId":"9",//行业类别id
 "personDesCard":"1",//个人标签
 "selfEvaluate":"1",//自我评价
 "workTime":"2018-09-14",//到岗时间
 "jobType":"0"//工作类型(0.全职 1.兼职)
 }
 @return <#return value description#>
 */
-(RHNetAPIManager*)appAddOrEditResumeOPT:(NSMutableDictionary *)params {
    
    self.aPath = @"/app/addOrEditResume.do";
    [self.params setValuesForKeysWithDictionary:params];
    return self;
}

#pragma mark 根据id获取工作经验
/**
 根据id获取工作经验
 
 @param params token(必填)
 data{"id":"21"}//id(必填)
 @return <#return value description#>
 */
-(RHNetAPIManager*)appGetResumeWorkExperienceByIdOPT:(NSMutableDictionary *)params {
    
    self.aPath = @"/app/getResumeWorkExperienceById.do";
    [self.params setValuesForKeysWithDictionary:params];
    return self;
}
#pragma mark 根据id获取项目经验
/**
 根据id获取项目经验
 
 @param params token(必填)
 data{"id":"21"}//id(必填)
 @return <#return value description#>
 */
-(RHNetAPIManager*)appGetResumeProjectExperienceByIdOPT:(NSMutableDictionary *)params {
    
    self.aPath = @"/app/getResumeProjectExperienceById.do";
    [self.params setValuesForKeysWithDictionary:params];
    return self;
}

#pragma mark 根据id获取教育经历
/**
 根据id获取教育经历
 
 @param params token(必填)
 data{"id":"21"}//id(必填)
 @return <#return value description#>
 */
-(RHNetAPIManager*)appGetResumeEduExperienceByIdOPT:(NSMutableDictionary *)params {
    
    self.aPath = @"/app/getResumeEduExperienceById.do";
    [self.params setValuesForKeysWithDictionary:params];
    return self;
}
#pragma mark 根据id获取技能
/**
 根据id获取技能
 
 @param params token(必填)
 data{"id":"21"}//id(必填)
 @return <#return value description#>
 */
-(RHNetAPIManager*)appGetResumeSkillPointByIdOPT:(NSMutableDictionary *)params {
    
    self.aPath = @"/app/getResumeSkillPointById.do";
    [self.params setValuesForKeysWithDictionary:params];
    return self;
}

#pragma mark 新增编辑简历工作经验
/**
 新增编辑简历工作经验
 
 @param params token(必填)
 data:{
 "id":"",//工作经验id(新增不填,编辑必填)
 "resumeId":"75",//简历id(新增不填,编辑必填)
 "workJob":"kpl水军2",//职能(必)
 "workPosition":"kpl水军1",//职位(必)
 "workClassId":"12",//行业类别id
 "scale":0,//公司规模(0:50人以下,1:5-100人,2:100人以上)
 "companyType":0,//公司性质（0.私营 1.上市公司 2.国企）
 "startTime":"2018-11-02",//开始时间
 "endTime":"2018-11-03",//结束时间
 "locCompany":"测试公司",//公司名称
 "department":"123",//部门
 "workDescrib":"213123123213",//工作描述
 "jobType":0//工作类型(0.全职 1.兼职)
 }

 @return <#return value description#>
 */
-(RHNetAPIManager*)appAddOrEditResumeWorkExperienceOPT:(NSMutableDictionary *)params {
    
    self.aPath = @"/app/addOrEditResumeWorkExperience.do";
    [self.params setValuesForKeysWithDictionary:params];
    return self;
}

#pragma mark 新增编辑简历项目经验
/**
 新增编辑简历项目经验
 
 @param params token(必)
 data:{
 "id":"",//项目经验id(新增传"",编辑必填)
 "resumeId":"75",//简历id(必)
 "proName":"芯连芯",//项目名称(必)
 "startTime":"2018-11-02",//开始时间(必)
 "endTime":"2018-11-03",//结束时间(必)
 "locCompany":"213123",//公司(必)
 "proDescrib":"213213213",//项目描述(必)
 "responsibility":"213123213"//责任描述
 }
 @return <#return value description#>
 */
-(RHNetAPIManager*)appAddOrEditResumeProjectExperienceOPT:(NSMutableDictionary *)params {
    
    self.aPath = @"/app/addOrEditResumeProjectExperience.do";
    [self.params setValuesForKeysWithDictionary:params];
    return self;
}
#pragma mark 新增编辑简历教育经历
/**
 新增编辑简历教育经历
 
 @param params token(必)
 data:{
 "id":"",//教育经历id(新增传"",编辑必填)
 "resumeId":"75",//简历id(必)
 "startTime":"2018-11-02",//开始时间(必)
 "endTime":"2018-11-02",//结束时间(必)
 "school":"华南里分工",//学校(必)
 "educationLevel":1,//学历(必,学历 (1.大专 2.本科 3.研究生 4.博士))
 "major":"123",//专业(必)
 "describ":"21332",//专业描述(必)
 "overseasExp":1//海外经历（0.无 1.有）(必)
 }
 @return <#return value description#>
 */
-(RHNetAPIManager*)appAddOrEditResumeEduExperienceOPT:(NSMutableDictionary *)params {
    
    self.aPath = @"/app/addOrEditResumeEduExperience.do";
    [self.params setValuesForKeysWithDictionary:params];
    return self;
}

#pragma mark 新增编辑简历技能
/**
 新增编辑简历技能
 
 @param params token(必)
 data:{
 "id":"",//技能id(新增不传,编辑必填)
 "resumeId":"75",//若先填写此模块此字段不传,若其他模块已近填写,此字段必填
 "skillName":"四级",//技能名称(必)
 "credential":"四级"//证书名称(必)
 }
 @return <#return value description#>
 */
-(RHNetAPIManager*)appAddOrEditResumeSkillPointOPT:(NSMutableDictionary *)params {
    
    self.aPath = @"/app/addOrEditResumeSkillPoint.do";
    [self.params setValuesForKeysWithDictionary:params];
    return self;
}

#pragma mark 简历是否默认公开初始化
/**
 简历是否默认公开初始化
 
 @param params data: {"resumeId":"1"}//必填
 token(必填)
 @return <#return value description#>
 */
-(RHNetAPIManager*)appGetResumeOpenTypeAndDefaultOPT:(NSMutableDictionary *)params {
    
    self.aPath = @"/app/getResumeOpenTypeAndDefault.do";
    [self.params setValuesForKeysWithDictionary:params];
    return self;
}
#pragma mark 编辑简历头部基本信息
/**
 编辑简历头部基本信息
 
 @param params token(必)
 data:{
 "resumeId":"50",//简历id,(新增为"")(必)
 "id":"3",//个人信息id(必)
 "realName":"陈晓成",//姓名(必)
 "sex":1,//性别(0.男 1.女)(必)
 "brithday":"2018-10-23",//生日(必)
 "wantJobStatus":1,//求职状态 0，正在找工作 1，已入职(必)
 "ceilPhone":"136323548718",//电话(必)
 "email":"12345678@qq.com",//邮箱(必)
 "freshGraduates":0,//应届毕业 0，否 1，是(必)
 "startWorkTime":"2018-10-23",//开始工作时间(必)
 "positionId":"411526"//居住地iid(必)
 "personDescrib":""//个人描述(选),
 "headPicImgId":"1016" ,//图片id(必)
 "headPic":"http://183.60.229.149/group1/M00/00/10/tzzllVvgL_qAXiyAAACWgOuQzV4983.jpg"//图片路径(必)
 }
 @return <#return value description#>
 */
-(RHNetAPIManager*)appEditBaseInfoOPT:(NSMutableDictionary *)params {
    
    self.aPath = @"/app/editBaseInfo.do";
    [self.params setValuesForKeysWithDictionary:params];
    return self;
}
#pragma mark  发布简历
/**
 发布简历
 
 @param params token(必)
 data{"resumeId":"168"}//简历id(必)
 @return <#return value description#>
 */
-(RHNetAPIManager*)appPushResumeOPT:(NSMutableDictionary *)params {
    
    self.aPath = @"/app/pushResume.do";
    [self.params setValuesForKeysWithDictionary:params];
    return self;
}

#pragma mark - 企业端
#pragma mark - 获取企业认证信息
/**
 获取企业认证信息
 
 @param params token//必填
 @return <#return value description#>
 */
-(RHNetAPIManager*)appGetCompanyAuthInfoOPT:(NSMutableDictionary *)params {
    
    self.aPath = @"/app/user/getCompanyAuthInfo.do";
    [self.params setValuesForKeysWithDictionary:params];
    return self;
}
#pragma mark 企业认证
/**
企业认证
 
 @param params token:必填
 data: {
 "id":"42",//公司id(必填)
 "companyName":"因卖丝",//公司名(必填)
 "businessLicenseImgIds":"797,800,",//营业执照id,逗号分隔,最多两张(必填)
 "businessLicense":"797,800,",//营业执照id,逗号分隔,最多两张(必填)
 "socialUnifiedCreditCode":"12314564561",//社会统一信用码//(必填)
 "businessToPublicAccount":"13156456841321321",//企业对公账号(选填)
 "accountOpeningBank":"昭山淫航",//开户银行(选填)
 "idCardZmId":798,//身份证正面照id(必填)
 "idCardFmId":799//身份证反面照id(必填)
 }
 @return <#return value description#>
 */
-(RHNetAPIManager*)appCompanyAuthOPT:(NSMutableDictionary *)params {
    
    self.aPath = @"/app/user/companyAuth.do";
    [self.params setValuesForKeysWithDictionary:params];
    return self;
}

#pragma mark - 首页 ----------------------------------
#pragma mark 企业端首页
/**
 企业端首页
 
 @return <#return value description#>
 */
-(RHNetAPIManager*)appCompanyIndexOPT{
    
    self.aPath = @"/app/user/companyIndex.do";
    return self;
}
#pragma mark 企业端简历搜索
/**
 企业端简历搜索
 
 @param params token(必)
 data:{
 "keyWords": "java", 搜索关键词
 "workClassId": "12,13,14", 工作类别id
 "workExpType": 2,     0.不限,1.应届毕业，2.1-3年，3.3-5年，4.5-10年，5.10年以上,6一年以下
 "salaryRangeIds": "1,2", 薪资范围 0.不限，1.2千以下，2.2-4千，3.4-6千 4.6-8千 5.8-10千 6.10千以上
 "aeraId":"440300",//区域id
 "maxEducationLevel":"1"//(0,不限 1.大专 2.本科 3.研究生 4.博士)
 },
 page:{pageSize:10,currPage:1},//页码
 @return <#return value description#>
 */
-(RHNetAPIManager*)appSearchResumeByConditionOPT:(NSMutableDictionary *)params {
    
    self.aPath = @"/app/searchResumeByCondition.do";
    [self.params setValuesForKeysWithDictionary:params];
    return self;
}
#pragma mark 获取企业端热门搜索
/**
 获取企业端热门搜索
 
 @return <#return value description#>
 */
-(RHNetAPIManager*)appGetCompanyHotSearchOPT{
    
    self.aPath = @"/app/getCompanyHotSearch.do";
    return self;
}

#pragma mark 企业端简历详情
/**
 企业端简历详情
 
 @param params data: {"resumeId":"1"}//必填
 token(必填)
 @return <#return value description#>
 */
-(RHNetAPIManager*)appResumeDetailOPT:(NSMutableDictionary *)params {
    
    self.aPath = @"/app/resumeDetail.do";
    [self.params setValuesForKeysWithDictionary:params];
    return self;
}

#pragma mark 简历收藏
/**
 简历收藏
 
 @param params token 必填
 data {"resumeId":"42"} rusumeId 简历id
 @return <#return value description#>
 */
-(RHNetAPIManager*)appCollectResumeOPT:(NSMutableDictionary *)params {
    
    self.aPath = @"/app/collectResume.do";
    [self.params setValuesForKeysWithDictionary:params];
    return self;
}

#pragma mark 取消简历收藏
/**
 取消简历收藏
 
 @param params token 必填
 data {"resumeId":"42"} rusumeId 简历id
 @return <#return value description#>
 */
-(RHNetAPIManager*)appCannelResumeCollectionOPT:(NSMutableDictionary *)params {
    
    self.aPath = @"/app/cannelResumeCollection.do";
    [self.params setValuesForKeysWithDictionary:params];
    return self;
}

#pragma mark 企业端邀请投递
/**
 企业端邀请投递
 
 @param params token 必填
 data {"resumeId":"42"} rusumeId 简历id
 @return <#return value description#>
 */
-(RHNetAPIManager*)appInviteSendResumeOPT:(NSMutableDictionary *)params {
    
    self.aPath = @"/app/cjUserMetting/inviteSendResume.do";
    [self.params setValuesForKeysWithDictionary:params];
    return self;
}
#pragma mark - 简历 ----------------------------------
#pragma mark 职位列表
/**
 职位列表
 
 @param params token:(必)
 data:{
 status:"0".招聘中 1.未发布 2.已暂停(必)(写死0)
 }
 page:
 {
 "currPage":当前页,(必)
 "pageSize":一页几条(必)
 }
 @return <#return value description#>
 */
-(RHNetAPIManager*)appPostsListOPT:(NSMutableDictionary *)params {
    
    self.aPath = @"/app/post/postsList.do";
    [self.params setValuesForKeysWithDictionary:params];
    return self;
}
#pragma mark 近半年 简历列表
/**
 近半年 简历列表
 
 @param params token(必)
 data{string型
 type//(选)全部不传,0:待处理,1:待确认,2:待面试,3:不合适,4:已拒绝,5:已取消,6:已完成
 workYear//工作年限(选)不限不传,1:应届,2:1年以上,3:2年以上,3:3年以上,4:5年以上
 realName//求职者姓名(选)
 workPosition//岗位名称(选)
 maxEduLevel//学历(选)不限不传,1:大专,2:本科,3:研究生,4:博士
 wantSalaryId//薪资范围(选)不限不传,1:0-3k,2:3-5k,3:5-7k,4:7-9k,5:9-11k,6:11k以上
 sixM//近半年(传1,不然不传)
 }
 page:{"currPage":1,"pageSize":10}
 @return <#return value description#>
 */
-(RHNetAPIManager*)appResumeCentralOPT:(NSMutableDictionary *)params {
    
    self.aPath = @"/app/ResumeCentral.do";
    [self.params setValuesForKeysWithDictionary:params];
    return self;
}
#pragma mark 面试结果反馈
/**
 面试结果反馈
 
 @param params data:{
 "mettingId":"3", 面试id(必)
 "resultType":"1" 反馈结果，默认为0(0.面试通过 1.面试失败)(必)
 }
 token:(必填)

 @return <#return value description#>
 */
-(RHNetAPIManager*)appPassMettingOPT:(NSMutableDictionary *)params {
    
    self.aPath = @"/app/cjUserMetting/passMetting.do";
    [self.params setValuesForKeysWithDictionary:params];
    return self;
}

#pragma mark 简历不合适
/**
 简历不合适
 
 @param params data:{
 "mettingId":"3",面试id
 "refuseMsg":"我们不合适" 拒绝原因
 }
 token//必填
 
 @return <#return value description#>
 */
-(RHNetAPIManager*)appNoSuitableOPT:(NSMutableDictionary *)params {
    
    self.aPath = @"/app/cjUserMetting/noSuitable.do";
    [self.params setValuesForKeysWithDictionary:params];
    return self;
}

#pragma mark 面试前两小时取消面试
/**
 面试前两小时取消面试
 
 @param params data:{
 "mettingId":"3" 面试id
 }
 token:(必填)
 
 @return <#return value description#>
 */
-(RHNetAPIManager*)appComCancelMettingOPT:(NSMutableDictionary *)params {
    
    self.aPath = @"/app/cjUserMetting/comCancelMetting.do";
    [self.params setValuesForKeysWithDictionary:params];
    return self;
}

#pragma mark 面试邀约
/**
 面试邀约
 
 @param params data:{
 "mettingId": "1", 面试id
 "mettingDate": "2018-07-31 08:42:29", 面试时间
 "facePlace": "大铁棍子医院",     面试地点
 "facePeopleName": "捅主任",     联系人
 "facePeoplePhone": "12342234323",联系方式
 "isChoiceEmail": "1",     是否发邮件（0否 1是）
 "isChoiceMsg": "1",     是否发短信（0否 1是）
 "inviteMsg": "来来来" }    邀请信息
 token://必填
 
 @return <#return value description#>
 */
-(RHNetAPIManager*)appInviteMettingOPT:(NSMutableDictionary *)params {
    
    self.aPath = @"/app/cjUserMetting/inviteMetting.do";
    [self.params setValuesForKeysWithDictionary:params];
    return self;
}

#pragma mark 邀请面试数据初始化
/**
 邀请面试数据初始化
 
 @param params token(必填)
 data{"metId":"198"}(必填)//面试id,stirng型
 
 @return <#return value description#>
 */
-(RHNetAPIManager*)appToInterviewNoticeOPT:(NSMutableDictionary *)params {
    
    self.aPath = @"/app/cjUserMetting/toInterviewNotice.do";
    [self.params setValuesForKeysWithDictionary:params];
    return self;
}
#pragma mark -  发布 -----------------------------------------
#pragma mark 新增/编辑职位初始化
/**
 新增/编辑职位初始化
 
 @param params token(必)
 data:{"postId":"38"}//新增不填,编辑必填
 
 @return <#return value description#>
 */
-(RHNetAPIManager*)appToAppEditPostOPT:(NSMutableDictionary *)params {
    
    self.aPath = @"/app/post/toAppEditPost.do";
    [self.params setValuesForKeysWithDictionary:params];
    return self;
}
#pragma mark 改变岗位状态
/**
 改变岗位状态
 
 @param params token(必)
 data:{
 "postId":"40",(必)
 "status":"2"(0.招聘中 1.未发布 2.已暂停)',必填
 }
 
 @return <#return value description#>
 */
-(RHNetAPIManager*)appUpdatePostStatusToPauseOPT:(NSMutableDictionary *)params {
    
    self.aPath = @"/app/post/updatePostStatusToPause.do";
    [self.params setValuesForKeysWithDictionary:params];
    return self;
}

#pragma mark 发布/保存职位
/**
 发布/保存职位
 
 @param params token(必)
 data:{
 "postId":"1",岗位id(首次新增某一模块信息时为空,后续新增其他模块必填)
 "postMoney":"20.00",职位押金(postMoneyOpen=1时必填)
 "jobName":"java工程师",岗位名称(调用此接口必填)
 "department":"解决方案",//部门(status=0时必填)
 "workYear":"0",//工作经验(0,应届生 1.1-2年 2.3-5年 3.5-10年,4.10年以上)(status=0时必填)
 "industryClassId":"1",行业类别id(status=0时必填)
 "workAddressRegionId":"1",就职区域id(status=0时必填)
 "educationLevel":"0",//学历 (0,不限 1.大专 2.本科 3.研究生 4.博士)(status=0时必填)
 "companyAddress":"固戍地跌",//公司地址(status=0时必填)
 "salaryRangeId":"1",//薪资范围id(status=0时必填)
 "detailedTreatment":"面议",//详细待遇(status=0时必填)
 "desCardIds":"1,2",//福利描述卡id(选填)
 "otherGood":"123",其他福利(选)
 "jobDuty":"123",//工作内容(status=0时必填)
 "workTime":"09:00~12:00"//工作时间(选)
 "workStyle":"办公室"//工作方式(选)
 "foodSituation":"0",餐补情况(0:无,1:有)(选)
 "bedSituation":"0"//住宿情况(0:无,1:有)(选)
 "socialGood":"一档社保",//社保福利(选)
 "totalPay":"5000-10000"//综合工资(status=0时必填)
 "basicPay":"试用期底薪2300元，试用期保低绩效为1300元，基本工资最低3600元"//(status=0时必填)
 "payPlan":"每月18日发放上月薪资"//发薪安排(status=0时必填)
 "workRequirement":"234",//任职要求(status=0时必填)
 "status":"0",//发布状态(0.招聘中 1.未发布 2.已暂停)(必)
 "postMoneyOpen":"1"//是否开启职位押金(0:关闭,1:开启)(必)
 }
 
 @return <#return value description#>
 */
-(RHNetAPIManager*)appAddPostOPT:(NSMutableDictionary *)params {
    
    self.aPath = @"/app/post/addPost.do";
    [self.params setValuesForKeysWithDictionary:params];
    return self;
}

#pragma mark - 企业中心 -----------------------------------------
#pragma mark 企业端公司详情
/**
 企业端公司详情
 
 @param params token//必填
 @return <#return value description#>
 */
-(RHNetAPIManager*)appToCompanyInfoDetailOPT:(NSMutableDictionary *)params {
    
    self.aPath = @"/app/mobile/toCompanyInfoDetail.do";
    [self.params setValuesForKeysWithDictionary:params];
    return self;
}
#pragma mark 公司详情保存
/**
 公司详情保存
 
 @param params token:登录token
 data:{
 "id":"1",//公司id
 "logo":"",公司logoid
 "companyName":"",//公司名称
 "scale":"",    //公司规模  '企业规模(0:1-50人；1:50-100人；2：100-500人；3：500人以上)',
 "companyType":"",//公司类型  0.上市公司 1.国企 2.民营 3.股份制 4.事业单位5.国家机关 6.合资 -1.其他
 "companyEmail":"",//公司邮箱
 "industryClassId":"", //行业类别id
 "companyHostUrl":"",//公司官网
 "companyArea":"",    //公司区域id
 "companyAddress":"",//公司地址
 "companyDescribe":"",//公司介绍
 "companyEnvironmentalPicIds":"" //公司环境id ids集合必须上传5张图片id eg "1,2,3,4,5"
 }

 @return <#return value description#>
 */
-(RHNetAPIManager*)appSaveInfoCenterCompanyOPT:(NSMutableDictionary *)params {
    
    self.aPath = @"/app/info/saveInfoCenterCompany.do";
    [self.params setValuesForKeysWithDictionary:params];
    return self;
}
#pragma mark 企业端系统消息
/**
 企业端系统消息
 
 @param params token(必)
 page:{"currPage":1,"pageSize":10}(必)
 @return <#return value description#>
 */
-(RHNetAPIManager*)appCompanyStationNewsOPT:(NSMutableDictionary *)params {
    
    self.aPath = @"/app/stationNews/companyStationNews.do";
    [self.params setValuesForKeysWithDictionary:params];
    return self;
}

#pragma mark 查询公司联系人列表
/**
 查询公司联系人列表
 
 @param params token(必填)登录token
 page {"currPage":1,"pageSize":10} currPage 页码数  pageSize 一页显示多少条
 @return <#return value description#>
 */
-(RHNetAPIManager*)appCompanyContactsListOPT:(NSMutableDictionary *)params {
    
    self.aPath = @"/app/user/CompanyContactsList.do";
    [self.params setValuesForKeysWithDictionary:params];
    return self;
}

#pragma mark 新增或编辑公司联系人
/**
 新增或编辑公司联系人
 
 @param params  token 必填 登录token
 data {"userName":"成现实1","phone":"13632545698","id":"1"}   userName 联系人姓名   phone 联系人电话  id 联系人id  当新增时不填写  编辑时携带id
 @return <#return value description#>
 */
-(RHNetAPIManager*)appEditCompanyContactsOPT:(NSMutableDictionary *)params {
    
    self.aPath = @"/app/user/editCompanyContacts.do";
    [self.params setValuesForKeysWithDictionary:params];
    return self;
}

#pragma mark 删除联系人
/**
 删除联系人
 
 @param params token(必)
 data:{id:"1"}//必
 @return <#return value description#>
 */
-(RHNetAPIManager*)appDeleteCompanyContanctOPT:(NSMutableDictionary *)params {
    
    self.aPath = @"/app/user/deleteCompanyContanct.do";
    [self.params setValuesForKeysWithDictionary:params];
    return self;
}

#pragma mark - 公共
#pragma mark 省市区
/**
 省市区
 
 @return <#return value description#>
 */
-(RHNetAPIManager*)appFindCityListOPT{
    self.aPath = @"/app/city/findCityList.do";
    return self;
}

#pragma mark 行业类别
/**
 行业类别
 
 @return <#return value description#>
 */
-(RHNetAPIManager*)appFindWorkClassListOPT{
    self.aPath = @"/app/workClass/findWorkClassList.do";
    return self;
}

#pragma mark 搜索条件数据
/**
 搜索条件数据
 
 @return <#return value description#>
 */
-(RHNetAPIManager*)appSearchCriteriaOPT{
    self.aPath = @"/app/searchCriteria.do";
    return self;
}
#pragma mark 图片上传base64
/**
 图片上传base64
 @param params imgurl://图片base64编码   picName//图片名称
 @return <#return value description#>
 */
-(RHNetAPIManager*)appUploadFileOPT:(NSMutableDictionary *)params {
    self.aPath = @"/app/fileManager/appUploadFile.do";
    [self.params setValuesForKeysWithDictionary:params];
    return self;
}
#pragma mark 定位
/**
 定位
 @param params token(必)
 @return <#return value description#>
 */
-(RHNetAPIManager*)appLocationOPT:(NSMutableDictionary *)params {
    self.aPath = @"/app/city/location.do";
    [self.params setValuesForKeysWithDictionary:params];
    return self;
}

@end
