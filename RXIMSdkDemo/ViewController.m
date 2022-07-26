//
//  ViewController.m
//  RXIMSdkDemo
//
//  Created by 陈汉 on 2021/8/18.
//

#import <RXIMSdk/RXIMSdk.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import "ViewController.h"
#import "TestActivity.h"

// - 设备屏幕宽
#define kScreenWidth          [UIScreen mainScreen].bounds.size.width
// - 设备屏幕高
#define kScreenHeight         [UIScreen mainScreen].bounds.size.height

static NSString *target;

@interface ViewController ()<RXIMMessageDelegate,RXIMSessionServiceDelegate>

@property (nonatomic, strong) RXIMMessage *msgObj;
@property (nonatomic, strong) NSString *conversationId;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *targetId;
@property (nonatomic, assign) RXIMSessionType covType;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[RXIMSDKManager sharedSDK] initWithProductId:@"test_product" channelId:@"test_channel" cpid:1000000];
    NSString *userPhoneName = [[UIDevice currentDevice] name];
    __weak typeof(self) weakself = self;
    if ([userPhoneName isEqualToString:@"陈汉的iPhone (2)"] || [userPhoneName isEqualToString:@"iPhone1"]) {
        weakself.userId = @"testuser_8888";
        weakself.targetId = @"testuser_9999";
        [[RXIMSDKManager sharedSDK] loginRXIMSDKWithUserId:weakself.userId clientType:262657 complete:^(RXIMError * _Nonnull error) {
            if (!error) {
                [RXIMSingleService sharedSDK].delegate = weakself;
                [RXIMSessionService sharedSDK].delegate = weakself;
            }
        }];
    }else if([userPhoneName isEqualToString:@"iPhone (2)"]){
        weakself.userId = @"testuser_9999";
        weakself.targetId = @"testuser_8888";
        [[RXIMSDKManager sharedSDK] loginRXIMSDKWithUserId:weakself.userId clientType:262657 complete:^(RXIMError * _Nonnull error) {
            if (!error) {
                [RXIMSingleService sharedSDK].delegate = weakself;
                [RXIMSessionService sharedSDK].delegate = weakself;
            }
        }];
    }else{
        weakself.userId = @"testuser_7777";
        weakself.targetId = @"testuser_8888";
        [[RXIMSDKManager sharedSDK] loginRXIMSDKWithUserId:weakself.userId clientType:262657 complete:^(RXIMError * _Nonnull error) {
            if (!error) {
                [RXIMSingleService sharedSDK].delegate = weakself;
                [RXIMSessionService sharedSDK].delegate = weakself;
            }
        }];
    }
    self.conversationId = @"$2$test888899";
    self.covType = RXIMSessionType_group;
    [self setUI];
//    [[RXIMSDKManager sharedSDK] logout];
}

- (void)setUI
{
    UILabel *chatLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 100, kScreenWidth-20, 30)];
    [chatLab setText:@"======= 聊天操作 ======="];
    [self.view addSubview:chatLab];
    
    UIButton *sendSingle = [[UIButton alloc] initWithFrame:CGRectMake(10, 140, 150, 30)];
    [sendSingle setTitle:@"切换单聊" forState:UIControlStateNormal];
    [sendSingle setBackgroundColor:[UIColor lightGrayColor]];
    [sendSingle addTarget:self action:@selector(sendSingleAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendSingle];
    
    UIButton *sendGroup = [[UIButton alloc] initWithFrame:CGRectMake(180, 140, 150, 30)];
    [sendGroup setTitle:@"切换群聊" forState:UIControlStateNormal];
    [sendGroup setBackgroundColor:[UIColor lightGrayColor]];
    [sendGroup addTarget:self action:@selector(sendGroupAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendGroup];
    
    UIButton *getHistoryMsg = [[UIButton alloc] initWithFrame:CGRectMake(10, 180, 150, 30)];
    [getHistoryMsg setTitle:@"获取本地历史消息" forState:UIControlStateNormal];
    [getHistoryMsg setBackgroundColor:[UIColor lightGrayColor]];
    [getHistoryMsg addTarget:self action:@selector(getLocalHistoryMsgAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:getHistoryMsg];
    
    UIButton *getSerHistoryMsg = [[UIButton alloc] initWithFrame:CGRectMake(180, 180, 150, 30)];
    [getSerHistoryMsg setTitle:@"获取服务器历史消息" forState:UIControlStateNormal];
    [getSerHistoryMsg setBackgroundColor:[UIColor lightGrayColor]];
    [getSerHistoryMsg addTarget:self action:@selector(getSerHistoryMsgAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:getSerHistoryMsg];
    
    UIButton *sendTextMsg = [[UIButton alloc] initWithFrame:CGRectMake(10, 220, 150, 30)];
    [sendTextMsg setTitle:@"发送文本消息" forState:UIControlStateNormal];
    [sendTextMsg setBackgroundColor:[UIColor lightGrayColor]];
    [sendTextMsg addTarget:self action:@selector(sendTextMsgAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendTextMsg];
    
    UIButton *sendImgMsg = [[UIButton alloc] initWithFrame:CGRectMake(180, 220, 150, 30)];
    [sendImgMsg setTitle:@"发送图片消息" forState:UIControlStateNormal];
    [sendImgMsg setBackgroundColor:[UIColor lightGrayColor]];
    [sendImgMsg addTarget:self action:@selector(sendImgMsgAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendImgMsg];
    
    UIButton *sendAudioMsg = [[UIButton alloc] initWithFrame:CGRectMake(10, 260, 150, 30)];
    [sendAudioMsg setTitle:@"发送语音消息" forState:UIControlStateNormal];
    [sendAudioMsg setBackgroundColor:[UIColor lightGrayColor]];
    [sendAudioMsg addTarget:self action:@selector(sendAudioMsgAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendAudioMsg];
    
    UIButton *sendLocationMsg = [[UIButton alloc] initWithFrame:CGRectMake(180, 260, 150, 30)];
    [sendLocationMsg setTitle:@"发送位置消息" forState:UIControlStateNormal];
    [sendLocationMsg setBackgroundColor:[UIColor lightGrayColor]];
    [sendLocationMsg addTarget:self action:@selector(sendLocationMsgAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendLocationMsg];
    
    UIButton *sendVideoMsg = [[UIButton alloc] initWithFrame:CGRectMake(10, 300, 150, 30)];
    [sendVideoMsg setTitle:@"发送视频消息" forState:UIControlStateNormal];
    [sendVideoMsg setBackgroundColor:[UIColor lightGrayColor]];
    [sendVideoMsg addTarget:self action:@selector(sendVideoMsgAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendVideoMsg];
    
    UIButton *sendFileMsg = [[UIButton alloc] initWithFrame:CGRectMake(180, 300, 150, 30)];
    [sendFileMsg setTitle:@"发送文件消息" forState:UIControlStateNormal];
    [sendFileMsg setBackgroundColor:[UIColor lightGrayColor]];
    [sendFileMsg addTarget:self action:@selector(sendFileMsgAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendFileMsg];
    
    UIButton *sendReplyMsg = [[UIButton alloc] initWithFrame:CGRectMake(10, 340, 130, 30)];
    [sendReplyMsg setTitle:@"发送回复消息" forState:UIControlStateNormal];
    [sendReplyMsg setBackgroundColor:[UIColor lightGrayColor]];
    [sendReplyMsg addTarget:self action:@selector(sendReplyMsgAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendReplyMsg];
    
    UILabel *sessionLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 400, kScreenWidth-20, 30)];
    [sessionLab setText:@"======= 会话操作 ======="];
    [self.view addSubview:sessionLab];
    
    UIButton *creatConv = [[UIButton alloc] initWithFrame:CGRectMake(10, 440, 150, 30)];
    [creatConv setTitle:@"创建会话" forState:UIControlStateNormal];
    [creatConv setBackgroundColor:[UIColor lightGrayColor]];
    [creatConv addTarget:self action:@selector(creatConvAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:creatConv];
    
    UIButton *deleteConv = [[UIButton alloc] initWithFrame:CGRectMake(180, 440, 150, 30)];
    [deleteConv setTitle:@"删除会话" forState:UIControlStateNormal];
    [deleteConv setBackgroundColor:[UIColor lightGrayColor]];
    [deleteConv addTarget:self action:@selector(deleteConvAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:deleteConv];
    
    UIButton *updateConvInfo = [[UIButton alloc] initWithFrame:CGRectMake(10, 480, 150, 30)];
    [updateConvInfo setTitle:@"更新会话数据" forState:UIControlStateNormal];
    [updateConvInfo setBackgroundColor:[UIColor lightGrayColor]];
    [updateConvInfo addTarget:self action:@selector(updateConvInfoAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:updateConvInfo];
    
    UIButton *getConvInfo = [[UIButton alloc] initWithFrame:CGRectMake(180, 480, 150, 30)];
    [getConvInfo setTitle:@"获取会话信息" forState:UIControlStateNormal];
    [getConvInfo setBackgroundColor:[UIColor lightGrayColor]];
    [getConvInfo addTarget:self action:@selector(getConvInfoAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:getConvInfo];
    
    UIButton *joinConv = [[UIButton alloc] initWithFrame:CGRectMake(10, 520, 150, 30)];
    [joinConv setTitle:@"加入会话" forState:UIControlStateNormal];
    [joinConv setBackgroundColor:[UIColor lightGrayColor]];
    [joinConv addTarget:self action:@selector(joinConvAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:joinConv];
    
    UIButton *leaveConv = [[UIButton alloc] initWithFrame:CGRectMake(180, 520, 150, 30)];
    [leaveConv setTitle:@"离开会话" forState:UIControlStateNormal];
    [leaveConv setBackgroundColor:[UIColor lightGrayColor]];
    [leaveConv addTarget:self action:@selector(leaveConvAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leaveConv];
    
    UIButton *updateUserInfoConv = [[UIButton alloc] initWithFrame:CGRectMake(10, 560, 150, 30)];
    [updateUserInfoConv setTitle:@"更新用户在会话中信息" forState:UIControlStateNormal];
    [updateUserInfoConv setBackgroundColor:[UIColor lightGrayColor]];
    [updateUserInfoConv addTarget:self action:@selector(updateUserInfoConvAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:updateUserInfoConv];
    
    UIButton *getConvList = [[UIButton alloc] initWithFrame:CGRectMake(180, 560, 150, 30)];
    [getConvList setTitle:@"获取服务器会话列表" forState:UIControlStateNormal];
    [getConvList setBackgroundColor:[UIColor lightGrayColor]];
    [getConvList addTarget:self action:@selector(getServerSessionList) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:getConvList];
    
    UIButton *sessions_ser = [[UIButton alloc] initWithFrame:CGRectMake(10, 600, 150, 30)];
    [sessions_ser setTitle:@"获取本地会话列表" forState:UIControlStateNormal];
    [sessions_ser setBackgroundColor:[UIColor lightGrayColor]];
    [sessions_ser addTarget:self action:@selector(getConvListAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sessions_ser];
    
    UIButton *clearUnreadCount = [[UIButton alloc] initWithFrame:CGRectMake(180, 600, 150, 30)];
    [clearUnreadCount setTitle:@"清空会话未读消息数" forState:UIControlStateNormal];
    [clearUnreadCount setBackgroundColor:[UIColor lightGrayColor]];
    [clearUnreadCount addTarget:self action:@selector(clearUnreadCount) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:clearUnreadCount];
    
    UIButton *getConversation = [[UIButton alloc] initWithFrame:CGRectMake(10, 640, 150, 30)];
    [getConversation setTitle:@"根据会话id获取会话" forState:UIControlStateNormal];
    [getConversation setBackgroundColor:[UIColor lightGrayColor]];
    [getConversation addTarget:self action:@selector(getConversationWithCovId) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:getConversation];
    
    UIButton *deleteLocalConv = [[UIButton alloc] initWithFrame:CGRectMake(180, 640, 150, 30)];
    [deleteLocalConv setTitle:@"删除本地单个会话" forState:UIControlStateNormal];
    [deleteLocalConv setBackgroundColor:[UIColor lightGrayColor]];
    [deleteLocalConv addTarget:self action:@selector(deleteLocalSingleConv) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:deleteLocalConv];
}

#pragma mark - ====== 消息操作 ======
#pragma mark - 发送单聊
-(void)sendSingleAction
{
    NSComparisonResult res = [self.userId compare:self.targetId];
    if (res == NSOrderedAscending) {
        self.conversationId = [NSString stringWithFormat:@"$1$%@:%@",self.userId,self.targetId];
    }else{
        self.conversationId = [NSString stringWithFormat:@"$1$%@:%@",self.targetId,self.userId];
    }
    self.covType = RXIMSessionType_single;
    [SVProgressHUD showSuccessWithStatus:@"切换单聊成功"];
}

#pragma mark - 发送群聊
-(void)sendGroupAction
{
    self.conversationId = @"$2$test888899";
    self.covType = RXIMSessionType_group;
    [SVProgressHUD showSuccessWithStatus:@"切换群聊成功"];
}

#pragma mark - 发送文本消息
- (void)sendTextMsgAction
{
    RXIMMsgTextContent *textContent = [[RXIMMsgTextContent alloc] init];
    textContent.text = @"text111";
    RXIMSendMessage *msg = [[RXIMSendMessage alloc] init];
    msg.conversationId = self.conversationId;
    msg.content = textContent;
    msg.covType = self.covType;
    msg.type = RXIMMessageType_Text;
    [[RXIMSingleService sharedSDK] sendMessage:msg completionHandler:^(RXIMMessage * _Nullable message, RXIMError * _Nonnull error) {
        if (!error) {
            
        }
    }];
}

#pragma mark - 发送图片消息
- (void)sendImgMsgAction
{
    NSString *imgPath = [[NSBundle mainBundle] pathForResource:@"location" ofType:@"png"];
    NSData *imageData = [[NSData alloc] initWithContentsOfFile:imgPath];
    UIImage *image = [UIImage imageWithContentsOfFile:imgPath];
    RXIMMsgImageContent *imgContent = [[RXIMMsgImageContent alloc] init];
    imgContent.original_data = imageData;
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *result = [path objectAtIndex:0];
    imgContent.path = result;
    imgContent.width = image.size.width;
    imgContent.height = image.size.height;
    RXIMSendMessage *msg = [[RXIMSendMessage alloc] init];
    msg.content = imgContent;
    msg.conversationId = self.conversationId;
    msg.covType = self.covType;
    msg.type = RXIMMessageType_Image;
    [RXIMSingleService sharedSDK].delegate = self;
    [[RXIMSingleService sharedSDK] sendMessage:msg completionHandler:^(RXIMMessage * _Nullable message, RXIMError * _Nonnull error) {
        if (!error) {
            
        }
    }];
}

#pragma mark - 发送语音消息
- (void)sendAudioMsgAction
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"audio" ofType:@"amr"];
    NSData *audioData = [[NSData alloc] initWithContentsOfFile:filePath];
    RXIMMsgAudioContent *audioContent = [[RXIMMsgAudioContent alloc]init];
    audioContent.duration = 3;
    audioContent.audioData = audioData;
    RXIMSendMessage *msg = [[RXIMSendMessage alloc] init];
    msg.content = audioContent;
    msg.conversationId = self.conversationId;
    msg.covType = self.covType;
    msg.type = RXIMMessageType_Audio;
    [[RXIMSingleService sharedSDK] sendMessage:msg completionHandler:^(RXIMMessage * _Nullable message,RXIMError *error) {
        if (!error) {
            
        }
    }];
}

#pragma mark - 发送位置消息
- (void)sendLocationMsgAction
{
    NSString *geoPath = [[NSBundle mainBundle] pathForResource:@"location" ofType:@"png"];
    NSData *geoData = [[NSData alloc] initWithContentsOfFile:geoPath];
    RXIMMsgLBSContent *geoContent = [[RXIMMsgLBSContent alloc]init];
    geoContent.name = @"经济开发区七区";
    geoContent.latitude = 43.844622945296109;
    geoContent.longitude = 125.37923983960859;
    geoContent.cover_data = geoData;
    RXIMSendMessage *msg = [[RXIMSendMessage alloc] init];
    msg.content = geoContent;
    msg.conversationId = self.conversationId;
    msg.covType = self.covType;
    msg.type = RXIMMessageType_Position;
    [[RXIMSingleService sharedSDK] sendMessage:msg completionHandler:^(RXIMMessage * _Nullable message,RXIMError *error){
        if (!error) {
            
        }
    }];
}

#pragma mark - 发送视频消息
- (void)sendVideoMsgAction
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"video" ofType:@"mp4"];
    NSData *videoData = [[NSData alloc] initWithContentsOfFile:filePath];
    
    filePath = [[NSBundle mainBundle] pathForResource:@"video_cover" ofType:@"png"];
    UIImage *coverImage = [UIImage imageWithContentsOfFile:filePath];
    NSData *coverData = [[NSData alloc] initWithContentsOfFile:filePath];
    
    RXIMMsgVideoContent *videoContent = [[RXIMMsgVideoContent alloc]init];
    videoContent.video_data = videoData;
    videoContent.cover_data = coverData;
    videoContent.size = videoData.length;
    videoContent.cover_width = coverImage.size.width;
    videoContent.cover_height = coverImage.size.height;
    videoContent.file_type = @"mp4";
    videoContent.duration = 3;
    
    RXIMSendMessage *msg = [[RXIMSendMessage alloc] init];
    msg.content = videoContent;
    msg.conversationId = self.conversationId;
    msg.covType = self.covType;
    msg.type = RXIMMessageType_Video;
    [[RXIMSingleService sharedSDK] sendMessage:msg completionHandler:^(RXIMMessage * _Nullable message,RXIMError *error){
        if (!error) {
            
        }
    }];
}

#pragma mark - 发送文件消息
- (void)sendFileMsgAction
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"file" ofType:@"txt"];
    NSData *fileData = [[NSData alloc] initWithContentsOfFile:filePath];
    
    RXIMMsgFileContent *fileContent = [[RXIMMsgFileContent alloc]init];
    fileContent.file_data = fileData;
    fileContent.file_type = @"txt";
    fileContent.size = fileData.length;
    fileContent.name = @"file";
    
    RXIMSendMessage *msg = [[RXIMSendMessage alloc] init];
    msg.content = fileContent;
    msg.conversationId = self.conversationId;
    msg.covType = self.covType;
    msg.type = RXIMMessageType_File;
    [[RXIMSingleService sharedSDK] sendMessage:msg completionHandler:^(RXIMMessage * _Nullable message,RXIMError *error){
        if (!error) {
            
        }
    }];
}

#pragma mark - 发送回复消息
- (void)sendReplyMsgAction
{
    if (self.msgObj == nil) {
        [SVProgressHUD showErrorWithStatus:@"引用消息不能为空"];
        return;
    }
    RXIMMsgReplyContent *replyContent = [[RXIMMsgReplyContent alloc]init];
    RXIMReferenceMsg *referenceMsg = [[RXIMReferenceMsg alloc]init];
    referenceMsg.sender = self.msgObj.sender;
    referenceMsg.type = self.msgObj.type;
    referenceMsg.msgId = self.msgObj.msgId;
    referenceMsg.content = self.msgObj.content;
    referenceMsg.milliTs = self.msgObj.milliTs;
    referenceMsg.subType = self.msgObj.subType;
    
    RXIMReplyMsg *replyMsg = [[RXIMReplyMsg alloc]init];
    replyMsg.type = RXIMMessageType_Text;
    RXIMMsgTextContent *textContent = [[RXIMMsgTextContent alloc]init];
    textContent.text = @"reply msg";
    replyMsg.content = textContent;
    
    replyContent.reference = referenceMsg;
    replyContent.reply = replyMsg;
    RXIMSendMessage *msg = [[RXIMSendMessage alloc] init];
    msg.content = replyContent;
    msg.conversationId = self.conversationId;
    msg.covType = self.covType;
    msg.type = RXIMMessageType_Reply;
    
    [[RXIMSingleService sharedSDK] sendMessage:msg completionHandler:^(RXIMMessage * _Nullable message,RXIMError *error){
        if (!error) {
            
        }
    }];
}

#pragma mark - 获取服务器历史消息
-(void)getSerHistoryMsgAction
{
    [[RXIMSingleService sharedSDK] getServerHistoryMessageWithMsgId:self.msgObj.msgId target:self.conversationId limit:30];
}

#pragma mark - 本地操作
#pragma mark - 获取本地历史消息
-(void)getLocalHistoryMsgAction
{
    [[RXIMSingleService sharedSDK] getLocalHistoryMessageWithMsgId:nil target:target sessionType:self.covType limit:100 completionHandler:^(NSArray<RXIMMessage *> * _Nonnull messages,RXIMError *error) {
        if (!error) {
            NSLog(@"历史消息回执 %@",messages);
        }
    }];
}

#pragma mark - ======== 会话操作 ======
#pragma mark 创建会话
-(void)creatConvAction
{
//    NSArray *members = @[@"testuser_7777",@"testuser_999"];
//    NSDictionary *dic = @{@"isRead":@"0"};
    
    NSArray *members = nil;
    NSDictionary *dic = nil;
    [[RXIMSessionService sharedSDK] creatConversation:self.conversationId option:0 creatorOption:0 members:members ext:dic completionHandler:^(RXIMError * _Nonnull error) {
        if (!error) {
            [SVProgressHUD showSuccessWithStatus:@"创建会话成功"];
        }else{
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"创建会话失败 error = %@",error.developerMessage]];
        }
    }];
}

#pragma mark - 删除会话
-(void)deleteConvAction
{
    [[RXIMSessionService sharedSDK] deleteConversation:self.conversationId completionHandler:^(RXIMError * _Nonnull error) {
        if (!error) {
            [SVProgressHUD showSuccessWithStatus:@"删除会话成功"];
        }else{
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"删除会话失败 error = %@",error.developerMessage]];
        }
    }];
}

#pragma mark - 更新会话信息
-(void)updateConvInfoAction
{
    NSDictionary *dic = @{@"isRead":@"1"};
    
//    NSDictionary *dic = nil;
    [[RXIMSessionService sharedSDK] updateConversationInfo:self.conversationId option:0 ext:dic completionHandler:^(RXIMError * _Nonnull error) {
        if (!error) {
            [SVProgressHUD showSuccessWithStatus:@"更新会话成功"];
        }else{
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"更新会话失败 error = %@",error.developerMessage]];
        }
    }];
}

#pragma mark - 获取会话信息
-(void)getConvInfoAction
{
    [[RXIMSessionService sharedSDK] getConversationInfo:self.conversationId completionHandler:^(RXIMSession * _Nonnull session, RXIMError * _Nonnull error) {
        if (!error) {
            [SVProgressHUD showSuccessWithStatus:@"获取会话成功"];
        }else{
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"获取会话信息失败 error = %@",error.developerMessage]];
        }
    }];
}

#pragma mark - 加入会话
-(void)joinConvAction
{
    [[RXIMSessionService sharedSDK] joinConversation:self.conversationId option:0 ext:nil completionHandler:^(RXIMError * _Nonnull error) {
        if (!error) {
            [SVProgressHUD showSuccessWithStatus:@"加入会话成功"];
        }else{
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"加入会话失败 error = %@",error.developerMessage]];
        }
    }];
}

#pragma mark - 离开会话
-(void)leaveConvAction
{
    [[RXIMSessionService sharedSDK] leaveConversation:self.conversationId completionHandler:^(RXIMError * _Nonnull error) {
        if (!error) {
            [SVProgressHUD showSuccessWithStatus:@"离开会话成功"];
        }else{
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"离开会话失败 error = %@",error.developerMessage]];
        }
    }];
}

#pragma mark - 更新用户在会话内信息
-(void)updateUserInfoConvAction
{
    NSDictionary *dic = @{@"isRead":@"1"};
    [[RXIMSessionService sharedSDK] updateUserInfoToConversation:self.conversationId option:0 ext:dic completionHandler:^(RXIMError * _Nonnull error) {
        if (!error) {
            [SVProgressHUD showSuccessWithStatus:@"更新会话内用户信息成功"];
        }else{
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"更新会话内用户信息失败 error = %@",error.developerMessage]];
        }
    }];
}

#pragma mark - 获取服务器会话列表
- (void)getServerSessionList
{
    [[RXIMSessionService sharedSDK] getConversationList:^(NSArray<RXIMSessionInfo *> * _Nonnull sessionInfoAry, RXIMError * _Nonnull error) {
        if (!error) {
            [SVProgressHUD showSuccessWithStatus:@"获取会话列表成功"];
        }else{
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"获取会话列表失败 error = %@",error.developerMessage]];
        }
    }];
}

#pragma mark - ====== 本地操作 ======
#pragma mark - 获取本地会话列表
-(void)getConvListAction
{
    NSArray *convList = [[RXIMSessionService sharedSDK] getLocalConversationList];
    NSLog(@"本地会话列表 %@",convList);
}

#pragma mark - 清空会话未读消息数
-(void)clearUnreadCount
{
    [[RXIMSessionService sharedSDK] clearRedPoint:self.conversationId complete:^(RXIMError * _Nonnull error) {
        if (!error) {
            [SVProgressHUD showSuccessWithStatus:@"清空成功"];
        }else{
            [SVProgressHUD showErrorWithStatus:@"清空失败"];
        }
    }];
}

#pragma mark - 根据会话id获取会话
-(void)getConversationWithCovId
{
    RXIMSession *session = [[RXIMSessionService sharedSDK] getConversationWithCovId:self.conversationId];
    NSLog(@"session = %@",session);
}

#pragma mark - 删除本地单个会话
-(void)deleteLocalSingleConv
{
    [[RXIMSessionService sharedSDK] deleteLocalSingleConversation:self.conversationId complete:^(RXIMError * _Nonnull error) {
        if (!error) {
            [SVProgressHUD showSuccessWithStatus:@"删除成功"];
        }else{
            [SVProgressHUD showErrorWithStatus:@"删除失败"];
        }
    }];
}

#pragma mark -- <RXIMMessageDelegate>
#pragma mark - 消息接收回执
- (void)receiveMessage:(NSArray<RXIMMessage *> *)msgs
{
    NSLog(@"接收消息");
    [SVProgressHUD showSuccessWithStatus:@"接收消息成功"];
}

#pragma mark - <RXIMMessageDelegate>
#pragma mark - 消息发送成功回执
- (void)sendMessageSuccess:(RXIMMessage *)msgObj
{
    NSLog(@"消息发送成功");
    self.msgObj = msgObj;
    [SVProgressHUD showSuccessWithStatus:@"发送成功"];
}

#pragma mark - 消息发送失败回执
- (void)sendMessageFailure:(RXIMMessage *)msgObj
{
    NSLog(@"消息发送失败");
}

#pragma mark - 历史消息回执
- (void)historyMessage:(RXIMHistoryMsgResp *)msgObj
{
    NSLog(@"历史消息回执 count = %ld",msgObj.count);
    if (!msgObj.isDone) {
        RXIMMessage *msg = msgObj.messages.firstObject;
        [[RXIMSingleService sharedSDK] getServerHistoryMessageWithMsgId:msg.msgId target:self.conversationId limit:30];
    }
}

#pragma mark - <RXIMSessionServiceDelegate>
#pragma mark - 会话最后一条消息变更
- (void)onSessionLastMessageChanged:(NSArray<RXIMSession *> *)sessions;
{
    NSLog(@"会话最后一条消息变更");
}

#pragma mark - 会话未读消息数变更
- (void)onSessionUnreadCountChanged:(NSArray<RXIMSession *> *)sessions
{
    NSLog(@"会话未读消息数变更");
}

@end
