#!/bin/sh

bundle exec rails runner Batch::GetArticles.get_articles
