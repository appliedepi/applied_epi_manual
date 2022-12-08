#' Run a tutorial using a specific language
#'
#' This function edits the Rmd for a specific intro course tutorial so that
#' the lang parameter is not English. Then it runs run_tutorial().
#'
#' @param rmd The quoted name of the Rmd you want to run. Do not add the .Rmd
#' extension. The name of the Rmd must be the same as the folder in which it resides
#' @param lang A two-letter abbreviation for the desired rendering language, e.g.
#' "fr", "en", or "ru". Must be reflected in a column in the translation spreadsheet.
#' @importFrom stringr str_glue
#' @importFrom stringr str_subset
#' @importFrom learnr run_tutorial
#' @export
#'
#' @examples
#' # run the tutorial in french
#' render_in_lang(rmd = "basics", lang = "fr")




render_in_lang <- function(rmd = "basics", lang = "en"){

  # store names of all tutorial folders
  tutorials <- list.dirs(path = system.file('tutorials', package = "introexerciseslangs"),
                        full.names = FALSE,
                        recursive = FALSE)

  # confirm that folder for rmd is in directory (Rmd and folder will have same name, like "basics")
    if (!rmd %in% tutorials) {

      message(str_glue("Tutorial '{rmd}' not found in the package introexerciseslangs. Did you build the package or misspell?"))

    # rmd is in the directory, proceed:
    } else {
        # read in the entire original Rmd file
        original <- readLines(con = system.file('tutorials', rmd, stringr::str_glue("{rmd}.Rmd"),
                                                package = "introexerciseslangs"))


        # # does not register length > 1 if multiple detects
        # returns warning if multiple detects: "longer object length is not a multiple of shorter object length"
        element <- stringr::str_subset(string = original, pattern = "lang:")


        # catch scenario where there is more than 1 instance of "lang:"
        if (length(element > 1)) {
          element <- element[1]
        }

        # record index number
        element_num <- which(original == element)

        # print original value
        message(stringr::str_glue("Original language is {original[[element_num]]}, on line {element_num}"))

        # make copy to edit
        modified <- original

        # replace with desired language code
        modified[[element_num]] <- stringr::str_glue("  lang: \"{lang}\"")

        # print the revision
        message(stringr::str_glue("On line {element_num}, {original[[element_num]]} has been replaced with {modified[[element_num]]}"))

        # overwrite the entire Rmd with the modified lang parameter
        writeLines(modified, con = system.file('tutorials', rmd, stringr::str_glue("{rmd}.Rmd"),
                                                package = "introexerciseslangs"))

        # run the tutorial
        learnr::run_tutorial(name = rmd, package = "introexerciseslangs", shiny_args = list(launch.browser = 0, port = 3838, host = '0.0.0.0'))
      }

      }

# tips
# https://stackoverflow.com/questions/38203263/write-line-to-a-specific-index-in-r
# apparently not possible to edit by specific index. Have to overwrite entire file as above.
