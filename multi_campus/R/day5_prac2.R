ggplot(economics, aes(x = date, y = pop)) + geom_line()

library(lubridate)

economics$year <- year(economics$date)
economics$month <- month(economics$date, label = TRUE)

econ2000 <- economics[which(economics$year >= 2000), ]

library(scales)

g <- ggplot(econ2000, aes(x = month, y = pop))

g <- g + geom_line(aes(color = factor(year), group = year))
g <- g + scale_color_discrete(name = " Year")
g <- g + scale_y_continuous(labels = comma)
g <- g + labs(title = "Pop Growth", x = "Month", y = "Pop")
g


say.hello <- function() {
  print("hello, world")
}

say.hello()

sprintf("hello %s", "peter")

hello.person <- function(name) {
  print(sprintf("hello %s", name))
}

hello.person("bob")
