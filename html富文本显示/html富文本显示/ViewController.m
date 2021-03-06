//
//  ViewController.m
//  html富文本显示
//
//  Created by dai.fengyi on 15/6/23.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    __weak IBOutlet UIWebView *webView;
    NSString *Futext;
}
@end
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    Futext = @"<p>\n  \n  \n   <!--IMG#0--><p> \n  \n  \n  \n   </p><!--IMG#1--> \n  \n <p>除了紫茎泽兰，堡坎上还长满了爬山虎、紫叶草等多种植物 记者 韦巧云 见习记者 黄乔 摄 </p> \n <p>“我们家这边遭外来植物侵害，希望相关部门来管一管！”近日，家住石坪桥建筑二村的居民梁先生致电本报称，外来入侵生物紫茎泽兰长在建筑二村34栋、35栋间的公路堡坎上，已泛滥成灾啦！</p> \n <p>居民称</p> \n <p>“绿油油的一大片，还挺好看！”</p> \n <p>6月9日，记者来到建筑二村了解情况。记者看到，两栋老房子间有一条4米多宽的斜坡公路，路边则是长约30多米，近10米高的石堡坎。远远望去，堡坎一片“绿意盎然”，被植物占据得几乎没有空隙。</p> \n <p>走近细看，堡坎上的植物除了梁先生所说的紫茎泽兰外，还有爬山虎、锯锯藤、紫叶草、黄葛树等六、七种植物。</p> \n <p>“我来这里住时堡坎还是秃的，后来植物越长越多，就成了现在这样。”65岁的封大妈在建筑二村住了二十多年，她告诉记者，自己不知道什么是紫茎泽兰，但她觉得堡坎上长着植物看上去更美观。</p> \n <p>接着，记者在建筑二村随机采访了过路的12位居民，其中11位表示“从没听说过紫茎泽兰”，同时也表示，植物长在堡坎上并没影响到生活，反而在夏季有遮阴的作用。</p> \n <p>“紫茎泽兰繁殖力很强，主要对农作物影响较大，对城市的危害还好吧。”曾在欧洲留学的蒋霞是12位居民中唯一听说过紫茎泽兰的居民，但她同样认为，堡坎上的植物并不影响居民生活。“我反而觉得这片植物带来更浓的生活气息，有国外小镇的感觉。”蒋霞说，让她唯一觉得危险的是，堡坎上越长越大的黄葛树，她怕树根会让堡坎产生裂缝，从而造成安全隐患。</p> \n <p>随后，带着梁先生反映的问题，记者来到了石坪桥街道后街社区居委会。“我们从没接到过居民反映紫茎泽兰影响生活的问题。”一位不愿意透露姓名的工作人员告诉记者，居委会只提醒过小区物管每年修理黄葛树。</p> \n <p>市农业环境监测站</p> \n <p>要引起警觉，会马上去处理！</p> \n <p>“如果是紫茎泽兰，需要除掉！”带着石坪桥建筑二村居民梁先生的担忧，记者致电市农业环境监测站了解情况。市农业环境监测站相关工作人员告诉记者，他们会尽快派人去现场查看，如果证实生长在石坪桥建筑二村的植物确实是紫茎泽兰，他们会立即处理掉。</p> \n <p>该负责人介绍，紫茎泽兰原产于墨西哥，从上世纪70年代开始进入中国，因其繁殖力强，已在2003年由中国国家环保总局和中国科学院发布的《中国第一批外来入侵物种名单》中名列第一位。</p> \n <p>“紫茎泽兰的生存力极强，在农田、牧草场、经济林地甚至荒山、荒地、沟边都能繁殖。”相关负责人介绍，紫茎泽兰植株内含有芳香和辛辣化学物质和一些尚不清楚的有毒物质，其花粉能引起人类过敏性疾病。同时，因其繁殖能力强，还会降低生物多样性，打破生态系统的整体平衡，使濒危植物和本地物种受到侵害，“相对于城市，紫茎泽兰对农村的影响更大一些。但是，在城市里面大面积生长的话，原有植物群落会迅速衰退、消失，也要引起警觉。”</p> \n <p>“紫茎泽兰其实已遍布我国西南大部分地区，重庆市比其他省份要好一些，蔓延和发展的趋势还不明显。”该负责人告诉记者，我市各区县农业环境监测站负责当地紫茎泽兰等外来入侵生物的监控和预测，如果市民发现紫茎泽兰等外来入侵生物，都可以与各区县农业主管部门联系，寻求处理。</p> \n <p>专家呼吁</p> \n <p>需加强外来入侵生物方面的知识普及</p> \n <p>近日，记者联系上在外来入侵生物方面的专家——西南大学植物保护学院教授谭万忠。谭教授告诉记者，我市外来入侵生物多达53种，其中最具危害性的外来入侵生物主要有空心莲子草（水花生）、凤眼莲（水葫芦）、紫茎泽兰、薇甘菊等，分布在我市的33个农业区县。</p> \n <p>“虽然每年我市都在进行外来入侵生物方面的宣传和普及，但是市民的知晓度还是不高，防止生物入侵需要全社会共同努力。”谭万忠说，市民往往分不清外来入侵生物，导致在旅游、贸易、运输等活动中有意或者无意引进了一些外来入侵生物，使得本地生态环境受到威胁。</p> \n <p>“植物入侵行为具有隐蔽性和突发性，一旦成功入侵，往往在短时间内形成大规模爆发，很难防范。”谭教授介绍说，前几年我市沙坪坝区就在疫情普查工作中查到“假高粱”恶性杂草117亩，引起了区政府高度重视，最后花大力气把其全部铲除掉。</p> \n <p>同时，市农业环境监测站相关负责人也表示，外来入侵生物的控制是一项系统工程，需要提高全社会的防范意识。他介绍，他们每年都会在各区县开展外来入侵生物方面的宣传教育，去年他们还组织科技人员编写了《农村外来入侵生物防治》等书籍，并在全市各区县推广、发放。</p> \n</p>";
    
//    [webView loadHTMLString:Futext baseURL:nil];
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"content_template" ofType:@"html"];
//    NSURL *url = [NSURL fileURLWithPath:path];
//    [webView loadRequest:[NSURLRequest requestWithURL:url]];

        NSURL *baseURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"content_template" ofType:@"html"];
        NSString *html = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        [webView loadHTMLString:html baseURL:baseURL];
}


@end
