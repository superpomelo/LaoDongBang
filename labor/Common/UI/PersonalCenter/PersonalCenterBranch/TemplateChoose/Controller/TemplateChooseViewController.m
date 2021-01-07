//
//  TemplateChooseViewController.m
//  labor
//
//  Created by 狍子 on 2021/1/5.
//  Copyright © 2021 ZKWQY. All rights reserved.
//

#import "TemplateChooseViewController.h"
#import "FirstTemplateChooseTableViewCell.h"
#import "PublishTaskViewController.h"

@interface TemplateChooseViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property(nonatomic,strong)NSArray *titleArray;
@property(nonatomic,strong)NSArray *subtitleArray;

@end

@implementation TemplateChooseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.titleArray = @[@"我为“劳动教育课程开展”献计献策",@"“致敬普通劳动者”主题活动",@"“幸福劳动者”采访活动",@"“从新冠肺炎看劳模精神之我感”主题演讲",@"争做家务小能手",@"为××做一顿美味营养餐",@"好习惯养成记",@"校园是我家，美化靠大家",@"技艺学堂——感受技能之美",@"记录精彩生活"];
    self.subtitleArray = @[@"一直以来，整个社会对劳动教育的讨论更多集中在中小学阶段，对大学劳动教育的关注明显不足。事实上，大学生作为直接面向劳动、直接对接职业的劳动后备军，比中小学生更迫切地需要带着全面系统的劳动素养走上工作岗位。\n作为新时代的一名大学生，你对“劳动教育课程的开展”有何建议?请认真阅读《中共中央国务院关于全面加强新时代大中小学劳动教育的意见》，利用互联网进行辅助，写一份意见报告（不少于800字)。",@"没有环卫工，哪有干净整洁的大街;没有保安员，哪有小区的祥和平安;没有快递员，哪能方便、快捷地买到心爱之物……每一座城市的美丽，都离不开基层劳动者辛勤的汗水和无私的付出，只要为社会创造价值，服务于人民，就是光荣的，只要是劳动者就该得到承认和尊重。\n请以小组（8~10 人）为单位组织一次“致敬普通劳动者”的主题活动，选择一个普通劳动者群体，向他们致敬。致敬的形式不限，既可以是发动社会力量为普通劳动者谋求福利，也可以是向普通劳动者献花，等等。要求活动过程用短视频的形式记录。",@"农民、工人、快递员、外卖员、房产中介、程序员、美工、设计师、工程师、作家、科学家、图书管理员……在我们身边，有很多这样的劳动者，他们既普通也不普通，他们凭着一份坚持，靠着不懈的奋斗，过上了属于自己的幸福生活。第一章人生在勤:劳动创造关好生活\n请以小组(4~6人)为单位寻找身边或网络上至少3个行业(应至少包括一个新兴行业）的“幸福劳动者”，采访他们的劳动故事，了解他们是如何通过劳动收获幸福的。要求采访过程和结果以PPT 或短视颊的形式呈现。",@"2020年春，一场突如其来的新冠肺炎疫情肆虐全国，举国上下万众一心，众志成城抗击疫情。在这场疫情防控阻击战中，医护人员等“战士”冲锋在前，在人民与病毒之间砌起高墙，在没有硝烟的战场上冲锋陷阵;纺织、保障供应等行业的劳模“战斗”在后，他们立足岗位，以行动支援前线……\n请以“从新冠肺炎看劳模精神之我感”为主题展开一场主题演讲比赛。",@"“一屋不扫，何以扫天下?”做家务似乎只是简单的重复性动作，是一件“小事”,但其实好处很多。我们不仅能通过做家务从喧嚣的网络世界中剥离出来,体验劳动的乐趣，还能深入体验专注的力量。\n请根据自己家庭的具体情况制订家务劳动计划，并严格执行计划。要求用PPT 或短视频的形式记录劳动过程，并在班级内展示、比拼。",@"中国饮食文化博大精深、源远流长。做饭既是一种基本生活需求，又是一门学问、一种艺术。一道色香味俱佳的菜肴，不仅令人赏心悦目，还能让人胃口大增，提升生活的幸福感。\n请以“为××做一顿美味营养餐”为主题开展一次实践活动。学生可以根据某一家人或朋友的喜好，为他/她准备一顿美味营养餐。要求用PPT或短视频的形式记录过程。",@"俗话说:“播种一种行为，收获一种习惯;播种一种习惯，收获一种性格，播种一种性格，收获一种命运。”习惯会对人产生很大的影响，一个人要想成功，就要先养成好的习惯。有了好的习惯，才能以更好的精力和状态去面对人生的挑战。\n请列举你认为值得养成的好习惯和对应的习惯养成计划，并按计划坚持21天。以PPT或短视频的形式记录自己养成习惯的过程，总结因为坚持这些习惯所发生的变化。",@"校园是我们学习和生活的地方，美丽整洁的校园环境会让我们不自觉地拥有一个好心情。作为学校的一分子，我们应为创造更加整洁、优美、温馨的学习与生活环境出一份力。\n请以班级为单位，组织一次校园美化活动。参与者可在门岗执勤、食堂餐盘清理、公共区域保洁、绿化维护等岗位中选择一个进行劳动实践，为校园关化贡献白己的力量。",@"传统手工艺是中国文化的母体，是民族情感、个性特征和民族凝聚力的载体，是中华民族文化艺术的瑰宝。手工制作工艺是生产者的艺术，它出自民间，服务于民，将实用和审美融于一体，带有物质和精神的双重性。传承传统手工艺，在社会、经济、文化和政治等诸多方面都有着重要的意义。\n根据自己的喜好，通过网络学习、拜访手艺人等方式，学习一种或多种传统技艺，亲身感受技能之美。",@"近年来，随着移动互联网和新媒体的快速发展，短视频行业迅速兴起。短视频以其制作简单、内容贴近生活等特征在大学生群体中广受欢迎。大学生制作短视频的过程也是一个塑造自我形象的过程，它不仅仅是简单地记录生活，还可以塑造自我、展现自我、完善自我。\n请你以短视频形式记录自己日常生活中的精彩片段，并进行适当的剪辑，制作成具有个人特色的短视频，在班级内展示。"];
    [self initmyTableView];
    [self initUI];
    self.fd_prefersNavigationBarHidden = YES;

}
//MARK: - Initalization - 初始化
- (void)initUI{
  
}
- (void)initmyTableView{
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.bounces = NO;
    [self.myTableView registerNib:[UINib nibWithNibName:@"FirstTemplateChooseTableViewCell" bundle:nil] forCellReuseIdentifier:@"FirstTemplateChooseTableViewCellID"];
 
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
 
   return 115;
  
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FirstTemplateChooseTableViewCell *cell = [self.myTableView dequeueReusableCellWithIdentifier:@"FirstTemplateChooseTableViewCellID"];
    [cell reloadData:self.titleArray[indexPath.row] subtitles:self.subtitleArray[indexPath.row]];
    return cell;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PublishTaskViewController *PTvc = [[PublishTaskViewController alloc]init];
    PTvc.titlestr = self.titleArray[indexPath.row];
    PTvc.content = self.subtitleArray[indexPath.row];
    [PTvc setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:PTvc animated:YES];
    
}
//MARK: - SubViews - 子视图
//MARK: - Button Action - 点击事件
- (IBAction)backButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}



//MARK: - Utility - 多用途(功能)方法
//MARK: - Network request - 网络请求

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
