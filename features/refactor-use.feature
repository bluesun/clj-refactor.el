Feature: Remove Use from ns form

  Background:
    Given I have a project "cljr" in "tmp"
    And I have a clojure-file "tmp/src/cljr/core.clj"
    And I open file "tmp/src/cljr/core.clj"
    And I clear the buffer

  Scenario: Replacing :use with :require :refer :all
    When I insert:
    """
    (ns cljr.foo
      (:require [cljr.foobar :as foo])
      (:use [cljr.core]
            [cljr.page]
            [cljr.element]
            [cljr.form]
            [some.lib ns1 ns2 ns3])
        (:refer-clojure :exclude [this that])
        (:import [java.util.Date]))
    """
    And I press "C-! ru"
    Then I should see:
    """
    (ns cljr.foo
      (:require [cljr.foobar :as foo]
                [cljr.core :refer :all]
                [cljr.page :refer :all]
                [cljr.element :refer :all]
                [cljr.form :refer :all]
                [some.lib.ns1 :refer :all]
                [some.lib.ns2 :refer :all]
                [some.lib.ns3 :refer :all])
        (:refer-clojure :exclude [this that])
        (:import [java.util.Date]))
    """
