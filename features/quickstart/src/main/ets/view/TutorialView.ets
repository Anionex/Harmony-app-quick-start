import {ArticleClass} from '../model/ArticleClass';
import { bufferToString } from '../util/BufferUtil';

@Component
export struct TutorialItem {
  @Prop tutorialItem: ArticleClass;

  build() {
    Row() {
      Column() {
        Text(this.tutorialItem.title)
          .height(19)
          .width('100%')
          .fontSize(14)
          .textAlign(TextAlign.Start)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .maxLines(1)
          .fontWeight(400)
          .margin({ top: 4 })
        Text(this.tutorialItem.brief)
          .height(32)
          .width('100%')
          .fontSize(12)
          .textAlign(TextAlign.Start)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .maxLines(2)
          .fontWeight(400)
          .fontColor('rgba(0, 0, 0, 0.6)')
          .margin({ top: 5 })
      }
      .height('100%')
      .layoutWeight(1) //自适应占满剩余空间
      .alignItems(HorizontalAlign.Start)
      .margin({ right: 12 })
      Image($r(this.tutorialItem.imageSrc))
        .height(64)
        .width(108)
        .objectFit(ImageFit.Cover)
        .borderRadius(16)
    }
    .width('100%')
    .height(88)
    .borderRadius(16)
    .backgroundColor(Color.White)
    .padding(12)
    .alignItems(VerticalAlign.Top)
  }
}

@Preview
@Component
export struct TutorialView{
  @State tutorialList: Array<ArticleClass> = [

  ]
  aboutToAppear(): void {  //在build前获取数据，一个aboutToAppear的回调函数
    this.getArticleDataFromJSON();
  }

  getArticleDataFromJSON() {
    getContext(this).resourceManager.getRawFileContent('TutorialData.json').then(value => {
      // 获取buffer内容
      let buffer: ArrayBufferLike = value.buffer;
      // 转换为字符串
      let res: string =  bufferToString(buffer);
      // 解析为数据结构
      this.tutorialList = JSON.parse(res) as ArticleClass[];
    })
  }
  build() {
    Column() {
      Text('入门教程')
        .fontColor('#182431')
        .fontSize(16)
        .fontWeight(500)
        .fontFamily('HarmonyHeiTi-medium')
        .textAlign(TextAlign.Start)
        .padding({ left: 16 })
        .margin({ bottom: 8.5 })
      List({ space: 12 }) {
        ForEach(this.tutorialList, (item: ArticleClass) => {
          ListItem() {
            TutorialItem({ tutorialItem: item })
          }
        }, (item: ArticleClass) => item.id)
      }
      .scrollBar(BarState.Off)
      .padding({ left: 16, right: 16 })
    }
    .margin({ top: 18 })
    .alignItems(HorizontalAlign.Start)
  }
}