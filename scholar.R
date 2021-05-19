# Using the google scholar package
#install.packages("scholar")

library(scholar)

# Roy's Google Scholar id
# from https://scholar.google.co.uk/citations?user=z6jaMRcAAAAJ&hl=en
roy_id <- "z6jaMRcAAAAJ&hl"

roy_pubs <- get_publications(roy_id)

roy_pubs <- roy_pubs[order(roy_pubs$year),]
roy_pubs <- roy_pubs[-1,] # Some random paper from 1977 credited to me!

# Output dataframe has author, title, journal, year, citations etc.
# also includes fields with unique journal and paper id codes which can
# probably be dropped.
roy_pubs <- subset(roy_pubs, select=-c(cid, pubid))
