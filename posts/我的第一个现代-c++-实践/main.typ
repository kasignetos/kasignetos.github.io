#import "../../../static/templates/template.typ": *
#import "@preview/codelst:2.0.2": sourcecode
#show: theme

#sourcecode(lang: "cpp")[```
import std;

auto main() -> int {
    auto mort = std::chrono::sys_days{std::chrono::year(192) / std::chrono::May / std::chrono::day(22)};
    auto today = std::chrono::sys_days{std::chrono::floor<std::chrono::days>(std::chrono::system_clock::now())};
    std::print("Today is {} days after 苦命鸳鸯\n", (today - mort).count());
    std::print("350234 days after 苦命鸳鸯 is: {}", std::chrono::year_month_day{mort + std::chrono::days(350234)});
    return 0;
}
```]

#[
    #set align(center)
    dongzhuo.cc
]

使用以下命令编译并测试：

#sourcecode(lang: "sh", numbering: none)[```
gcc -std=c++23 -fmodules -fsearch-include-path bits/std.cc file.cpp
gcc -std=c++23 -fmodules dongzhuo.cc -o dongzhuo
./dongzhuo
```]

效果如下：

#sourcecode(lang: "text", numbering: none)[```
    Today is 669684 days after 苦命鸳鸯
    350234 days after 苦命鸳鸯 is: 1151-04-20
```]

#closure(
  size: 16pt,
  segment-title: [\$EOF],
  segment: ()
)
