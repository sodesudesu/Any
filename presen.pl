require any;

&bar(
     "Perl/Tkxのお試し"
    );
&p(
   ["h", "ほげほげ"],
   ["t", "\x{2744} こんにちは！\n\x{2744} 私は^_~です。"]
  );
&p(
   ["h", "かきかき"],
   ["t", "大成功！"]
  );
&p(
   ["tw", "今考えていることは、文字の色をどのように変えるか。また、何色にするか。さらに、箇条書きの点をどのような関数で書くことが出るのか。"]
   );

Tkx::MainLoop;
