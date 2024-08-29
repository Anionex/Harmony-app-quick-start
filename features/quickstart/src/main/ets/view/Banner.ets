import {BannerClass} from '../model/BannerClass';
import { bufferToString } from '../util/BufferUtil';

@Preview
@Component
export struct Banner {
  @State bannerList: Array<BannerClass> = [

  ];
  aboutToAppear(): void {  //在build前获取数据，一个aboutToAppear的回调函数
    this.getBannerDataFromJSON();
  }

  getBannerDataFromJSON() {
    getContext(this).resourceManager.getRawFileContent('BannerData.json').then(value => {
      // 获取buffer内容
      let buffer: ArrayBufferLike = value.buffer;
      // 转换为字符串
      let res: string =  bufferToString(buffer);
      // 解析为数据结构
      this.bannerList = JSON.parse(res) as BannerClass[];
    })
  }


  build() {
    Swiper() {
      ForEach(this.bannerList, //数组

        (item: BannerClass, index: number) => { // 这个方法应该返回一个组件
          Image($r(item.imageSrc))
            .objectFit(ImageFit.Contain)
            .width('100%')
            .padding({ top: 11, left: 16, right: 16 })
            .borderRadius(16)
        },

        (item: BannerClass, index: number) => item.id) // 这个方法应该返回一个标识符，提高效率
    }
    .autoPlay(true)
    .loop(true)
    .indicator(
      new DotIndicator()
        .color('#1a000000')
        .selectedColor('#0A59F7'))

  }
}
