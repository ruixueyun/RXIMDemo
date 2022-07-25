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

@property (nonatomic, strong) NSString *msgId;
@property (nonatomic, strong) NSString *conversationId;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *targetId;
@property (nonatomic, assign) RXIMSessionType covType;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[RXIMSDKManager sharedSDK] initWithAppId:@"test_product" channelId:@"test_channel" cpid:1000000];
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
    
    NSComparisonResult res = [self.userId compare:self.targetId];
    if (res == NSOrderedAscending) {
        target = [NSString stringWithFormat:@"$1$%@:%@",self.userId,self.targetId];
    }else{
        target = [NSString stringWithFormat:@"$1$%@:%@",self.targetId,self.userId];
    }
    self.conversationId = @"$2$test8888";
    self.covType = RXIMSessionType_group;
    [self setUI];
//    [[RXIMSDKManager sharedSDK] logout];
}

- (void)setUI
{
    UILabel *chatLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 100, kScreenWidth-20, 30)];
    [chatLab setText:@"======= 聊天操作 ======="];
    [self.view addSubview:chatLab];
    
    //服务器会话列表
    UIButton *sendSingle = [[UIButton alloc] initWithFrame:CGRectMake(10, 140, 150, 30)];
    [sendSingle setTitle:@"发送单聊" forState:UIControlStateNormal];
    [sendSingle setBackgroundColor:[UIColor redColor]];
    [sendSingle addTarget:self action:@selector(sendSingleAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendSingle];
    
    //服务器会话列表
    UIButton *sendGroup = [[UIButton alloc] initWithFrame:CGRectMake(180, 140, 150, 30)];
    [sendGroup setTitle:@"发送群聊" forState:UIControlStateNormal];
    [sendGroup setBackgroundColor:[UIColor redColor]];
    [sendGroup addTarget:self action:@selector(sendGroupAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendGroup];
    
    //获取历史消息
    UIButton *getHistoryMsg = [[UIButton alloc] initWithFrame:CGRectMake(10, 180, 150, 30)];
    [getHistoryMsg setTitle:@"获取历史消息" forState:UIControlStateNormal];
    [getHistoryMsg setBackgroundColor:[UIColor redColor]];
    [getHistoryMsg addTarget:self action:@selector(getHistoryMsgAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:getHistoryMsg];
    
    //获取历史消息
    UIButton *getSerHistoryMsg = [[UIButton alloc] initWithFrame:CGRectMake(180, 180, 150, 30)];
    [getSerHistoryMsg setTitle:@"获取服务器历史消息" forState:UIControlStateNormal];
    [getSerHistoryMsg setBackgroundColor:[UIColor redColor]];
    [getSerHistoryMsg addTarget:self action:@selector(getSerHistoryMsgAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:getSerHistoryMsg];
    
    //文本消息
    UIButton *sendTextMsg = [[UIButton alloc] initWithFrame:CGRectMake(10, 220, 150, 30)];
    [sendTextMsg setTitle:@"发送文本消息" forState:UIControlStateNormal];
    [sendTextMsg setBackgroundColor:[UIColor redColor]];
    [sendTextMsg addTarget:self action:@selector(sendTextMsgAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendTextMsg];
    
    //图片消息
    UIButton *sendImgMsg = [[UIButton alloc] initWithFrame:CGRectMake(180, 220, 150, 30)];
    [sendImgMsg setTitle:@"发送图片消息" forState:UIControlStateNormal];
    [sendImgMsg setBackgroundColor:[UIColor redColor]];
    [sendImgMsg addTarget:self action:@selector(sendImgMsgAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendImgMsg];
    
    //语音消息
    UIButton *sendAudioMsg = [[UIButton alloc] initWithFrame:CGRectMake(10, 260, 150, 30)];
    [sendAudioMsg setTitle:@"发送语音消息" forState:UIControlStateNormal];
    [sendAudioMsg setBackgroundColor:[UIColor redColor]];
    [sendAudioMsg addTarget:self action:@selector(sendAudioMsgAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendAudioMsg];
    
    //位置消息
    UIButton *sendLocationMsg = [[UIButton alloc] initWithFrame:CGRectMake(180, 260, 150, 30)];
    [sendLocationMsg setTitle:@"发送位置消息" forState:UIControlStateNormal];
    [sendLocationMsg setBackgroundColor:[UIColor redColor]];
    [sendLocationMsg addTarget:self action:@selector(sendLocationMsgAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendLocationMsg];
    
    //视频消息
    UIButton *sendVideoMsg = [[UIButton alloc] initWithFrame:CGRectMake(10, 300, 150, 30)];
    [sendVideoMsg setTitle:@"发送视频消息" forState:UIControlStateNormal];
    [sendVideoMsg setBackgroundColor:[UIColor redColor]];
    [sendVideoMsg addTarget:self action:@selector(sendVideoMsgAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendVideoMsg];
    
    //文件消息
    UIButton *sendFileMsg = [[UIButton alloc] initWithFrame:CGRectMake(180, 300, 150, 30)];
    [sendFileMsg setTitle:@"发送文件消息" forState:UIControlStateNormal];
    [sendFileMsg setBackgroundColor:[UIColor redColor]];
    [sendFileMsg addTarget:self action:@selector(sendFileMsgAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendFileMsg];
    
    //回复消息
    UIButton *sendReplyMsg = [[UIButton alloc] initWithFrame:CGRectMake(10, 340, 130, 30)];
    [sendReplyMsg setTitle:@"发送回复消息" forState:UIControlStateNormal];
    [sendReplyMsg setBackgroundColor:[UIColor redColor]];
    [sendReplyMsg addTarget:self action:@selector(sendReplyMsgAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendReplyMsg];
    
    UILabel *sessionLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 400, kScreenWidth-20, 30)];
    [sessionLab setText:@"======= 会话操作 ======="];
    [self.view addSubview:sessionLab];
    
    //创建会话
    UIButton *creatConv = [[UIButton alloc] initWithFrame:CGRectMake(10, 440, 150, 30)];
    [creatConv setTitle:@"创建会话" forState:UIControlStateNormal];
    [creatConv setBackgroundColor:[UIColor redColor]];
    [creatConv addTarget:self action:@selector(creatConvAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:creatConv];
    
    //删除会话
    UIButton *deleteConv = [[UIButton alloc] initWithFrame:CGRectMake(180, 440, 150, 30)];
    [deleteConv setTitle:@"删除会话" forState:UIControlStateNormal];
    [deleteConv setBackgroundColor:[UIColor redColor]];
    [deleteConv addTarget:self action:@selector(deleteConvAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:deleteConv];
    
    //更新会话数据
    UIButton *updateConvInfo = [[UIButton alloc] initWithFrame:CGRectMake(10, 480, 150, 30)];
    [updateConvInfo setTitle:@"更新会话数据" forState:UIControlStateNormal];
    [updateConvInfo setBackgroundColor:[UIColor redColor]];
    [updateConvInfo addTarget:self action:@selector(updateConvInfoAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:updateConvInfo];
    
    //获取会话信息
    UIButton *getConvInfo = [[UIButton alloc] initWithFrame:CGRectMake(180, 480, 150, 30)];
    [getConvInfo setTitle:@"获取会话信息" forState:UIControlStateNormal];
    [getConvInfo setBackgroundColor:[UIColor redColor]];
    [getConvInfo addTarget:self action:@selector(getConvInfoAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:getConvInfo];
    
    //加入会话
    UIButton *joinConv = [[UIButton alloc] initWithFrame:CGRectMake(10, 520, 150, 30)];
    [joinConv setTitle:@"加入会话" forState:UIControlStateNormal];
    [joinConv setBackgroundColor:[UIColor redColor]];
    [joinConv addTarget:self action:@selector(joinConvAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:joinConv];
    
    //离开会话
    UIButton *leaveConv = [[UIButton alloc] initWithFrame:CGRectMake(180, 520, 150, 30)];
    [leaveConv setTitle:@"离开会话" forState:UIControlStateNormal];
    [leaveConv setBackgroundColor:[UIColor redColor]];
    [leaveConv addTarget:self action:@selector(leaveConvAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leaveConv];
    
    //更新用户在会话中信息
    UIButton *updateUserInfoConv = [[UIButton alloc] initWithFrame:CGRectMake(10, 560, 150, 30)];
    [updateUserInfoConv setTitle:@"更新用户在会话中信息" forState:UIControlStateNormal];
    [updateUserInfoConv setBackgroundColor:[UIColor redColor]];
    [updateUserInfoConv addTarget:self action:@selector(updateUserInfoConvAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:updateUserInfoConv];
    
    //获取会话列表
    UIButton *getConvList = [[UIButton alloc] initWithFrame:CGRectMake(180, 560, 150, 30)];
    [getConvList setTitle:@"获取服务器会话列表" forState:UIControlStateNormal];
    [getConvList setBackgroundColor:[UIColor redColor]];
    [getConvList addTarget:self action:@selector(getServerSessionList) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:getConvList];
    
    //获取服务器列表
    UIButton *sessions_ser = [[UIButton alloc] initWithFrame:CGRectMake(10, 600, 150, 30)];
    [sessions_ser setTitle:@"获取本地会话列表" forState:UIControlStateNormal];
    [sessions_ser setBackgroundColor:[UIColor redColor]];
    [sessions_ser addTarget:self action:@selector(getConvListAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sessions_ser];
    
}

-(void)sendSingleAction
{
    NSComparisonResult res = [self.userId compare:self.targetId];
    if (res == NSOrderedAscending) {
        self.conversationId = [NSString stringWithFormat:@"$1$%@:%@",self.userId,self.targetId];
    }else{
        self.conversationId = [NSString stringWithFormat:@"$1$%@:%@",self.targetId,self.userId];
    }
    self.covType = RXIMSessionType_single;
}

-(void)sendGroupAction
{
    self.conversationId = @"$2$test8888";
    self.covType = RXIMSessionType_group;
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
    RXIMMsgImageContent *imgContent = [[RXIMMsgImageContent alloc] init];
    UIImage *image = [UIImage imageNamed:@"wechat_login_image"];
    imgContent.original_data = UIImagePNGRepresentation(image);
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
    audioContent.path = @"";
    audioContent.duration = 10;
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
    RXIMMsgLBSContent *geoContent = [[RXIMMsgLBSContent alloc]init];
    geoContent.name = @"环球中心";
    geoContent.latitude = 1.0;
    geoContent.longitude = 1.0;
    UIImage *image = [UIImage imageNamed:@"wechat_login_image"];
    geoContent.cover_data = UIImagePNGRepresentation(image);
    
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
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"video" ofType:@"mp4"];
    NSData *fileData = [[NSData alloc] initWithContentsOfFile:filePath];
    
    RXIMMsgFileContent *fileContent = [[RXIMMsgFileContent alloc]init];
    fileContent.file_data = fileData;
    fileContent.file_type = @"txt";
    fileContent.size = fileData.length;
    fileContent.name = @"test";
    
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
    [[RXIMSingleService sharedSDK] replyMessage:self.msgId content:@"hello" target:self.conversationId sessionType:RXIMSessionType_single ext:nil completionHandler:^(RXIMMessage * _Nullable message,RXIMError *error) {
        if (!error) {
    
        }
    }];
}

#pragma mark - 获取历史消息
-(void)getHistoryMsgAction
{
    [[RXIMSingleService sharedSDK] getLocalHistoryMessageWithMsgId:nil target:target sessionType:self.covType limit:100 completionHandler:^(NSArray<RXIMMessage *> * _Nonnull messages,RXIMError *error) {
        if (!error) {
            NSLog(@"历史消息回执 %@",messages);
        }
    }];
}

#pragma mark - 获取服务器历史消息
-(void)getSerHistoryMsgAction
{
    [[RXIMSingleService sharedSDK] getServerHistoryMessageWithMsgId:nil target:self.conversationId limit:100];
}

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
    [[RXIMSessionService sharedSDK] getConversationList:self.conversationId completionHandler:^(NSArray<RXIMSessionInfo *> * _Nonnull sessionInfoAry, RXIMError * _Nonnull error) {
        if (!error) {
            [SVProgressHUD showSuccessWithStatus:@"获取会话列表成功"];
        }else{
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"获取会话列表失败 error = %@",error.developerMessage]];
        }
    }];
}

#pragma mark - 获取本地会话列表
-(void)getConvListAction
{
    NSArray *convList = [[RXIMSessionService sharedSDK] getLocalConversationList];
    NSLog(@"本地会话列表 %@",convList);
}

#pragma mark -- <代理>

#pragma mark - 消息接收回执
- (void)receiveMessage:(NSArray<RXIMMessage *> *)msgs
{
    NSLog(@"接收消息");
    [SVProgressHUD showInfoWithStatus:@"接收消息成功"];
}

#pragma mark - <RXIMMessageDelegate>
#pragma mark - 消息发送成功回执
- (void)sendMessageSuccess:(RXIMMessage *)msgObj
{
    NSLog(@"消息发送成功");
    self.msgId = msgObj.msgId;
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
    NSLog(@"历史消息回执");
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
