module ApplicationHelper
  def page_title(page_title = '')
    base_title = 'PrefectureQuiz'
    page_title.empty? ? base_title : page_title + ' | ' + base_title
  end

  def default_meta_tags
    {
      og: {
        title: 'PrefectureQuiz | 都道府県クイズアプリ',
        description: 'この写真、どこの都道府県でしょう？日本の風景の写真からどこの都道府県かを当てるクイズアプリです。',
        image: 'https://raw.githubusercontent.com/losaki/PrefectureQuiz/main/app/assets/images/service_image.jpeg'
      },
      twitter: {
        card: 'summary_large_image'
      }
    }
  end
end
