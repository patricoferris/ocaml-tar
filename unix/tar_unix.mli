(*
 * Copyright (C) 2006-2009 Citrix Systems Inc.
 *
 * Permission to use, copy, modify, and distribute this software for any
 * purpose with or without fee is hereby granted, provided that the above
 * copyright notice and this permission notice appear in all copies.
 *
 * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 *)

(** Unix I/O for tar-formatted data. *)

(** Return the header needed for a particular file on disk. *)
val header_of_file : ?level:Tar.Header.compatibility -> string -> Tar.Header.t

(** Fold over a tar archive. *)
val fold_tar :
  ((Tar.Header.t * Tar.Header.Extended.t option,
    [
      | `Eof
      | `Fatal of [ `Checksum_mismatch | `Corrupt_pax_header | `Unmarshal of string ]
      | `Unix of Unix.error
    ]) result -> 'a -> 'a) ->
  Unix.file_descr ->
  'a -> 'a

val append_file : ?header:Tar.Header.t -> string ->
