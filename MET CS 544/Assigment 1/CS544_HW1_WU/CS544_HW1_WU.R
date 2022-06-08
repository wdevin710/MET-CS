##Question1
##(a)
scores <- c(58, 46, 50, 90, 42, 52, 62, 44, 96, 92, 54, 82)
scores
##(b)
n <- length(scores)
n
##(c)
first_and_second <- scores[1:2]
first_and_second
##(d)
first_and_last <- scores[c(1,length(scores))]
first_and_last
##(e)
middle_two <- scores[c(6,7)]
middle_two

##Question2
##(a)
median_score <- median(scores)
median_score
##(b)
below_median <- scores <= median_score
below_median
##(c)
above_median <- scores > median_score
above_median
##(d)
count_below_median <- sum(below_median)
count_below_median
##(e)
count_above_median <- sum(above_median)
count_above_median


##Question3
##(a)
scores_below_median <- scores[below_median == "TRUE"]
scores_below_median
##(b)
scores_above_median <- scores[above_median == "TRUE"]
scores_above_median

##Question4
##(a)
odd_index_values <-  scores[seq(1, length(scores), 2)]
odd_index_values
##(b)
even_index_values <- scores[seq(0, length(scores), 2)]
even_index_values


##Question5
##(a)
format_scores_version1 <- paste(LETTERS[0:length(scores)],scores,sep = "=")
format_scores_version1
##(b)
format_scores_version2 <- paste(LETTERS[length(scores):0], scores, sep = "=")
format_scores_version2

##Question6
##(a)
scores_matrix <- matrix(scores, nrow = 2, ncol = 6, byrow = TRUE, dimnames = NULL)
scores_matrix
##(b)
first_and_last_version1 <- scores_matrix[,c(1,6)]
first_and_last_version1


##Question7
##(a)
named_matrix <- scores_matrix
rownames(named_matrix) <- rownames(named_matrix, do.NULL = FALSE, prefix = "Quiz_")
colnames(named_matrix) <- colnames(named_matrix, do.NULL = FALSE, prefix = "Student_")
named_matrix
##(b)
first_and_last_version2 <- named_matrix[,c(1,ncol(named_matrix))]
first_and_last_version2







