(*   _                     _
 *  | |__  _ __ ___   ___ | | __
 *  | '_ \| '__/ _ \ / _ \| |/ /
 *  | |_) | | | (_) | (_) |   <
 *  |_.__/|_|  \___/ \___/|_|\_\
 *
 * Microframework which helps to develop web Pascal applications.
 *
 * Copyright (c) 2012-2019 Silvio Clecio <silvioprog@gmail.com>
 *
 * This file is part of Brook framework.
 *
 * Brook framework is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * Brook framework is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with Brook framework.  If not, see <http://www.gnu.org/licenses/>.
 *)

unit Test;

{$I Tests.inc}

interface

uses
  SysUtils;

type
  TTestRoutine = procedure;

  TTestRoutineArgs = procedure(const AArgs: array of const);

  EOSErrorClass = class of EOSError;

{ args }

procedure AssertExcept(ARoutine: TTestRoutineArgs; AExceptClass: ExceptClass;
  const AError: string; const AArgs: array of const); overload;

procedure AssertExcept(ARoutine: TTestRoutineArgs; AExceptClass: ExceptClass;
  const AArgs: array of const); overload;

procedure AssertOSExcept(ARoutine: TTestRoutineArgs; const AError: string;
  ACode: Cardinal; const AArgs: array of const); overload;

procedure AssertOSExcept(ARoutine: TTestRoutineArgs; const AError: string;
  const AArgs: array of const); overload;

procedure AssertOSExcept(ARoutine: TTestRoutineArgs; ACode: Cardinal;
  const AArgs: array of const); overload;

procedure AssertOSExcept(ARoutine: TTestRoutineArgs;
  const AArgs: array of const); overload;

{ no args }

procedure AssertExcept(ARoutine: TTestRoutine; AExceptClass: ExceptClass;
  const AError: string); overload;

procedure AssertExcept(ARoutine: TTestRoutine;
  AExceptClass: ExceptClass); overload;

procedure AssertOSExcept(ARoutine: TTestRoutine; const AError: string;
  ACode: Cardinal); overload;

procedure AssertOSExcept(ARoutine: TTestRoutine;
  const AError: string); overload;

procedure AssertOSExcept(ARoutine: TTestRoutine; ACode: Cardinal); overload;

procedure AssertOSExcept(ARoutine: TTestRoutine); overload;

implementation

{ args }

procedure AssertExcept(ARoutine: TTestRoutineArgs; AExceptClass: ExceptClass;
  const AError: string; const AArgs: array of const);
var
  OK: Boolean;
begin
  Assert(Assigned(ARoutine));
  OK := False;
  try
    ARoutine(AArgs);
  except
    on E: Exception do
      OK := (E.ClassType = AExceptClass) and (E.Message = AError);
  end;
  Assert(OK);
end;

procedure AssertExcept(ARoutine: TTestRoutineArgs; AExceptClass: ExceptClass;
  const AArgs: array of const);
var
  OK: Boolean;
begin
  Assert(Assigned(ARoutine));
  OK := False;
  try
    ARoutine(AArgs);
  except
    on E: Exception do
      OK := E.ClassType = AExceptClass;
  end;
  Assert(OK);
end;

procedure AssertOSExcept(ARoutine: TTestRoutineArgs; const AError: string;
  ACode: Cardinal; const AArgs: array of const);
var
  OK: Boolean;
begin
  Assert(Assigned(ARoutine));
  OK := False;
  try
    ARoutine(AArgs);
  except
    on E: EOSError do
      OK := (E.ErrorCode = ACode) and (E.Message = AError);
  end;
  Assert(OK);
end;

procedure AssertOSExcept(ARoutine: TTestRoutineArgs; const AError: string;
  const AArgs: array of const);
var
  OK: Boolean;
begin
  Assert(Assigned(ARoutine));
  OK := False;
  try
    ARoutine(AArgs);
  except
    on E: EOSError do
      OK := E.Message = AError;
  end;
  Assert(OK);
end;

procedure AssertOSExcept(ARoutine: TTestRoutineArgs; ACode: Cardinal;
  const AArgs: array of const);
var
  OK: Boolean;
begin
  Assert(Assigned(ARoutine));
  OK := False;
  try
    ARoutine(AArgs);
  except
    on E: EOSError do
      OK := E.ErrorCode = ACode;
  end;
  Assert(OK);
end;

procedure AssertOSExcept(ARoutine: TTestRoutineArgs; const AArgs: array of const);
var
  OK: Boolean;
begin
  Assert(Assigned(ARoutine));
  OK := False;
  try
    ARoutine(AArgs);
  except
    on E: EOSError do
      OK := True;
  end;
  Assert(OK);
end;

{ no args }

procedure AssertExcept(ARoutine: TTestRoutine; AExceptClass: ExceptClass;
  const AError: string);
var
  OK: Boolean;
begin
  Assert(Assigned(ARoutine));
  OK := False;
  try
    ARoutine;
  except
    on E: Exception do
      OK := (E.ClassType = AExceptClass) and (E.Message = AError);
  end;
  Assert(OK);
end;

procedure AssertExcept(ARoutine: TTestRoutine; AExceptClass: ExceptClass);
var
  OK: Boolean;
begin
  Assert(Assigned(ARoutine));
  OK := False;
  try
    ARoutine;
  except
    on E: Exception do
      OK := E.ClassType = AExceptClass;
  end;
  Assert(OK);
end;

procedure AssertOSExcept(ARoutine: TTestRoutine; const AError: string;
  ACode: Cardinal);
var
  OK: Boolean;
begin
  Assert(Assigned(ARoutine));
  OK := False;
  try
    ARoutine;
  except
    on E: EOSError do
      OK := (E.ErrorCode = ACode) and (E.Message = AError);
  end;
  Assert(OK);
end;

procedure AssertOSExcept(ARoutine: TTestRoutine; const AError: string);
var
  OK: Boolean;
begin
  Assert(Assigned(ARoutine));
  OK := False;
  try
    ARoutine;
  except
    on E: EOSError do
      OK := E.Message = AError;
  end;
  Assert(OK);
end;

procedure AssertOSExcept(ARoutine: TTestRoutine; ACode: Cardinal);
var
  OK: Boolean;
begin
  Assert(Assigned(ARoutine));
  OK := False;
  try
    ARoutine;
  except
    on E: EOSError do
      OK := E.ErrorCode = ACode;
  end;
  Assert(OK);
end;

procedure AssertOSExcept(ARoutine: TTestRoutine);
var
  OK: Boolean;
begin
  Assert(Assigned(ARoutine));
  OK := False;
  try
    ARoutine;
  except
    on E: EOSError do
      OK := True;
  end;
  Assert(OK);
end;

end.