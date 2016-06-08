#import <UIKit/UIKit.h>

typedef enum {
    LKTopicTypeAll = 1,
    LKTopicTypePicture = 10,
    LKTopicTypeWord = 29,
    LKTopicTypeVoice = 31,
    LKTopicTypeVideo = 41
} LKTopicType;

/** 精华-所有顶部标题的高度 */
UIKIT_EXTERN CGFloat const LKTitlesViewH;
/** 精华-所有顶部标题的Y */
UIKIT_EXTERN CGFloat const LKTitlesViewY;
/** 精华-cell-间距 */
UIKIT_EXTERN CGFloat const LKTopicCellMargin;
/** 精华-cell-底部工具条的高度 */
UIKIT_EXTERN CGFloat const LKTopicCellButtonBarH;
/** 精华-cell-文字内容的Y值 */
UIKIT_EXTERN CGFloat const LKTopicCellTextY;

/** 精华-cell-图片帖子的最大高度 */
UIKIT_EXTERN CGFloat const LKTopicCellPictureMaxH;
/** 精华-cell-图片帖子一旦超过最大高度，就是用Breal */
UIKIT_EXTERN CGFloat const LKTopicCellPictureBreakH;

/** LKUser模型-性别属性值 */
UIKIT_EXTERN NSString * const LKUserSexMale;
UIKIT_EXTERN NSString * const LKUserSexFemale;

/** 精华-cell-最热评论标题的高度 */
UIKIT_EXTERN CGFloat const LKTopicCellTopCmtTitleH;