## To update the sysdata.rda, first uncomment the below. Run (note you'll need to link to google)
## Then you need to re-build the R package (look for the Build pane)
## Then BE SURE to RE-COMMENT out before saving/pushing.

## see: # https://usethis.r-lib.org/reference/use_data.html
## If still have trouble seeing the changes, click the drop-down next to
##    Run Document and clear the pre-rendered outputs before rendering.

pacman::p_load(googlesheets4, tidyr, rio, here, janitor)

test <- googlesheets4::read_sheet(
   "https://docs.google.com/spreadsheets/d/1GRvHou9l29MhyMSL1Wx3AOI9lUDrBmCOTJJycxrC1pw/edit#gid=1187534738",
   range = "test_chapter", col_types = "c") %>%
   clean_names()

export(test, here("translations", "data", "test.rds"))

