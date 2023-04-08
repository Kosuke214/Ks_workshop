# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create!(email: ENV['ADMIN_EMAIL'], password: ENV['ADMIN_PASSWORD'])

users = User.create!(
  [
    {email: 'hanako@example.com', last_name: '山田', first_name: '花子', nickname: 'ハナコ', diy_history: 0, introduction: '始めたばかりの初心者ですが、みなさんと一緒に上達していきたいと思います！', password: 'password', status: true, profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user2.png"), filename:"sample-user2.png")},
    {email: 'ichiro@example.com', last_name: '鈴木', first_name: '一郎', nickname: 'イチロー', diy_history: 1, introduction: '少しずつコツコツと色々なものに手を出しています。コメントやアドバイス等頂けると励みになります。', password: 'password',status: true, profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user3.png"), filename:"sample-user3.png")},
    {email: 'saburo@example.com', last_name: '田中', first_name: '三郎', nickname: 'サブロー', diy_history: 2, introduction: 'これからもっともっとステップアップしていきたいので、皆さんのアイディア等参考にさせていただけたらと思います！', password: 'password',status: true, profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user4.png"), filename:"sample-user4.png")}
  ]
)

posts = Post.create!(
  [
    {title: "収納箱リベンジ！", post_text: "前回のリベンジで簡単な収納箱を制作。前回失敗したつなぎ目部分の処理をこちらのサイトを参照し変更いたしました。\r\n\r\nhttp://ks-workshop.net/", is_deleted: false, is_hidden: false, post_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post1.jpg"), filename:"sample-post1.jpg"), user_id: users[0].id },
    {title: "サイドテーブル作ってみた", post_text: "こだわりの詰まったサイドテーブルを制作。以前からビリングでくつろぐ際にちょっとしたサイドテーブルが欲しかったのですがジャストサイズで作れて大満足です。", is_deleted: false, is_hidden: false, post_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post2.jpg"), filename:"sample-post2.jpg"), user_id: users[1].id },
    {title: "ついに購入しました！", post_text: "以前から欲しいと思っていたインパクトドライバーをついに購入しました！コツコツ貯めたお小遣いは消えましたが、、、これで制作意欲はマックスです！", is_deleted: false, is_hidden: false, post_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post3.jpg"), filename:"sample-post3.jpg"), user_id: users[2].id }
  ]
)

Comment.create!(
  [
    {comment_text: "参考URL為になりました！前回の投稿も拝見させていただいており、これからも楽しみに投稿お待ちしております。", is_deleted: false, is_hidden: false, user_id: users[1].id, post_id: posts[0].id },
    {comment_text: "投稿ありがとうございます。私の場合は別のやり方でいつも制作しております。今度投稿しますのでぜひご覧ください。", is_deleted: false, is_hidden: false, user_id: users[2].id, post_id: posts[0].id },
    {comment_text: "お部屋の雰囲気とも合っていて素晴らしいですね！", is_deleted: false, is_hidden: false, user_id: users[0].id, post_id: posts[1].id },
    {comment_text: "こちらのインパクト、私も欲しいと思っていました。今度レビューもぜひ投稿いただけたら大変参考になります！", is_deleted: false, is_hidden: false, user_id: users[1].id, post_id: posts[2].id }
  ]
)

