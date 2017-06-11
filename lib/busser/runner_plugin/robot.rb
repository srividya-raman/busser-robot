# -*- encoding: utf-8 -*-
#
# Author:: Srividya Raman <srividya.ramank@gmail.com>
#
# Copyright (C) 2017, Srividya Raman
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require "pathname"
require "busser/runner_plugin"

# A Busser runner plugin for Robot.
#
# @author Srividya Raman <srividya.ramank@gmail.com>
#
class Busser::RunnerPlugin::Robot < Busser::RunnerPlugin::Base
  postinstall do
     inside(Pathname.new(__FILE__).dirname.join("../../../vendor/robot")) do
      run!("python setup.py install")
    end
  end

  def test

    run!("pybot --pythonpath #{suite_path("robot")} -d robotlogs #{suite_path
    ("robot")}")
  end
end
